import 'package:breed_challenge/features/data/models/dog_breed_model.dart';
import 'package:breed_challenge/features/domain/entities/dog_breed_entity.dart';

abstract class IDogBreedsDatasource {
  Future<List<DogBreed>> getBreeds();
  Future<List<String>> getBreedPictures(String query);
  Future<List<DogBreedEntity>> getRandomBreedPictures(
      List<DogBreedEntity> query);
}
