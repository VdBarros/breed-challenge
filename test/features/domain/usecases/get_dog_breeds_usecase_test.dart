import 'package:breed_challenge/features/data/models/dog_breed_model.dart';
import 'package:breed_challenge/features/domain/entities/dog_breed_entity.dart';
import 'package:breed_challenge/features/domain/repositories/idog_breeds_repository.dart';
import 'package:breed_challenge/features/domain/usecases/external/get_dog_breeds_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:breed_challenge/core/erros/failures.dart';

class MockDogBreedsRepository extends Mock implements IDogBreedsRepository {}

void main() {
  late GetDogBreedsUsecase getDogBreedsUsecase;
  late IDogBreedsRepository repository;

  setUp(() {
    repository = MockDogBreedsRepository();
    getDogBreedsUsecase = GetDogBreedsUsecase(repository);
  });

  List<DogBreedEntity> tDogBreedEntityList = [
    DogBreed(breedName: 'breedName', subBreeds: []),
  ];

  final tFailure = ServerFailure();

  void runSuccessMock() {
    when(() => repository.getBreeds()).thenAnswer(
      (_) async => Right(tDogBreedEntityList),
    );
  }

  void runFailureMock() {
    when(() => repository.getBreeds()).thenAnswer(
      (_) async => Left(tFailure),
    );
  }

  test(
    'should call the DogBreedsRepository',
    () async {
      // Arrange
      runSuccessMock();

      // Act
      await getDogBreedsUsecase.call();

      // Assert
      verify(() => repository.getBreeds()).called(1);
    },
  );

  test(
    'should call the DogBreedsRepository and return a List of DogBreedEntity',
    () async {
      // Arrange
      runSuccessMock();

      // Act
      final result = await getDogBreedsUsecase.call();

      // Assert
      expect(result, Right(tDogBreedEntityList));
      verify(() => repository.getBreeds()).called(1);
    },
  );

  test(
    'should call the DogBreedsRepository and return a Failure',
    () async {
      // Arrange
      runFailureMock();

      // Act
      final result = await getDogBreedsUsecase.call();

      // Assert
      expect(result, Left(tFailure));
      verify(() => repository.getBreeds()).called(1);
    },
  );
}
