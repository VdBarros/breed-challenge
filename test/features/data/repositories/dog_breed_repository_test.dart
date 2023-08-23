import 'package:breed_challenge/features/data/datasources/external/idog_breeds_datasource.dart';
import 'package:breed_challenge/features/data/models/dog_breed_model.dart';
import 'package:breed_challenge/features/data/repositories/dog_breed_repository.dart';
import 'package:breed_challenge/features/domain/repositories/idog_breeds_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:breed_challenge/core/erros/exceptions.dart';
import 'package:breed_challenge/core/erros/failures.dart';

class MockDogBreedsDatasource extends Mock implements IDogBreedsDatasource {}

void main() {
  late DogBreedsRepository repository;
  late IDogBreedsDatasource datasource;

  setUp(() {
    datasource = MockDogBreedsDatasource();
    repository = DogBreedsRepository(datasource);
  });

  List<DogBreed> tDogBreedEntityList = [
    DogBreed(breedName: 'breedName', subBreeds: []),
  ];

  void runSuccessMock() {
    when(() => datasource.getBreeds()).thenAnswer(
      (_) async => tDogBreedEntityList,
    );
  }

  test('DogBreedsRepository should implements the IDogBreedsRepository', () {
    // Assert
    expect(repository, isA<IDogBreedsRepository>());
  });

  test(
      'when the repository gets called it should also call the DogBreedsDatasource inside',
      () async {
    // Arrange
    runSuccessMock();

    // Act
    await repository.getBreeds();

    // Assert
    verify(() => datasource.getBreeds()).called(1);
  });

  test('when the repository gets called it should returns a List of DogBreed',
      () async {
    // Arrange
    runSuccessMock();

    // Act
    final result = await repository.getBreeds();

    // Assert
    expect(result, Right(tDogBreedEntityList));
    verify(() => datasource.getBreeds()).called(1);
  });

  test(
      'should return a server failure when calls to the datasource is unsucessful',
      () async {
    // Arrange
    when(() => datasource.getBreeds()).thenThrow(ServerException());

    // Act
    final result = await repository.getBreeds();

    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => datasource.getBreeds()).called(1);
  });
}
