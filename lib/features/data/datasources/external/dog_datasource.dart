import 'dart:convert';

import 'package:breed_challenge/core/erros/exceptions.dart';
import 'package:breed_challenge/core/http/ihttp_client.dart';
import 'package:breed_challenge/features/data/datasources/external/end_points/dog_breeds_endpoints.dart';
import 'package:breed_challenge/features/data/datasources/external/idog_breeds_datasource.dart';
import 'package:breed_challenge/features/data/datasources/local/idatabase_helper_datasource.dart';
import 'package:breed_challenge/features/data/models/dog_breed_model.dart';
import 'package:breed_challenge/features/domain/entities/dog_breed_entity.dart';

class DogDatasource implements IDogBreedsDatasource {
  final IHttpClient httpClient;
  final IDatabaseHelperDataSource iDatabaseHelperDataSource;

  DogDatasource(this.httpClient, this.iDatabaseHelperDataSource);

  @override
  Future<List<DogBreed>> getBreeds() async {
    final response = await httpClient.get(DogBreedsEndpoints.getBreedsUrl);

    if (response.statusCode == 200) {
      final List<String> favorites =
          await iDatabaseHelperDataSource.getFavorites();
      final List<DogBreed> breeds = [];
      final Map<String, dynamic> jsonData = json.decode(response.data);

      jsonData['message'].forEach((key, value) {
        final breedName = key;
        final subBreeds = List<String>.from(value);

        final dogBreed = DogBreed.fromJson(breedName, subBreeds);
        dogBreed.isFavorite = favorites.contains(breedName);

        breeds.add(dogBreed);
      });

      return breeds;
    }

    throw ServerException();
  }

  @override
  Future<List<String>> getBreedPictures(String query) async {
    final response = await httpClient
        .get(DogBreedsEndpoints.getBreedImagesUrl(query: query));

    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.data)['message']);
    }

    throw ServerException();
  }

  @override
  Future<List<DogBreedEntity>> getRandomBreedPictures(
      List<DogBreedEntity> query) async {
    for (var element in query) {
      final response = await httpClient.get(
          DogBreedsEndpoints.getRandomBreedImagesUrl(query: element.breedName));
      if (response.statusCode == 200) {
        element.pictures =
            List<String>.from(json.decode(response.data)['message']);
      } else {
        throw ServerException();
      }
    }

    return query;
  }
}
