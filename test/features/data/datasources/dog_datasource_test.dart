import 'package:breed_challenge/core/http/ihttp_client.dart';
import 'package:breed_challenge/features/data/datasources/external/dog_datasource.dart';
import 'package:breed_challenge/features/data/datasources/external/idog_breeds_datasource.dart';
import 'package:breed_challenge/features/data/datasources/local/idatabase_helper_datasource.dart';
import 'package:breed_challenge/features/data/models/dog_breed_model.dart';
import 'package:breed_challenge/features/domain/entities/dog_breed_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:breed_challenge/core/erros/exceptions.dart';
import '../../mock/list_dog_breed_mock.dart';

class MockHttpClient extends Mock implements IHttpClient {}

class MockHDatabaseHelper extends Mock implements IDatabaseHelperDataSource {}

void main() {
  late IDogBreedsDatasource datasource;
  late IHttpClient httpClient;
  late IDatabaseHelperDataSource databaseHelperDataSource;

  setUp(() async {
    httpClient = MockHttpClient();
    databaseHelperDataSource = MockHDatabaseHelper();
    datasource = DogDatasource(httpClient, databaseHelperDataSource);
  });

  const String tUrl = 'https://dog.ceo/api/breeds/list/all';

  List<DogBreed> tDogBreedEntityList = [
    DogBreed(breedName: 'breedName', subBreeds: []),
  ];

  test(
    'DogDatasource should implements IDogBreedsDatasource',
    () {
      // Assert
      expect(datasource, isA<DogDatasource>());
    },
  );

  test(
    'should call the get method with the correct url when calls the datasource',
    () async {
      // Arrange
      when(() => httpClient.get(any())).thenAnswer(
        (_) async => HttpResponse(listDogBreedMock, 200),
      );

      when(() => databaseHelperDataSource.getFavorites())
          .thenAnswer((_) async => []);

      // Act
      datasource.getBreeds();

      // Assert
      verify(() => httpClient.get(tUrl)).called(1);
    },
  );

  test(
    'should returns a list of DogBreed when calls the datasource',
    () async {
      // Arrange
      when(() => httpClient.get(tUrl)).thenAnswer(
        (_) async => HttpResponse(listDogBreedMock, 200),
      );

      when(() => databaseHelperDataSource.getFavorites())
          .thenAnswer((_) async => []);

      // Act
      final result = await datasource.getBreeds();

      // Assert
      expect(result, isA<List<DogBreedEntity>>());
      verify(() => httpClient.get(tUrl)).called(1);
    },
  );

  test(
    'should throws a ServerException when calls the datasource',
    () async {
      // Arrange
      when(() => httpClient.get(tUrl)).thenAnswer(
        (_) async => HttpResponse('opps', 400),
      );

      // Act
      final result = datasource.getBreeds();

      // Assert
      expect(result, throwsA(ServerException()));
    },
  );
}
