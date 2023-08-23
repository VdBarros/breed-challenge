import 'package:breed_challenge/features/data/models/dog_breed_model.dart';
import 'package:breed_challenge/features/domain/entities/dog_breed_entity.dart';
import 'package:breed_challenge/features/domain/usecases/external/get_dog_breeds_usecase.dart';
import 'package:breed_challenge/features/domain/usecases/favorites/add_favorite_usecase.dart';
import 'package:breed_challenge/features/domain/usecases/favorites/delete_favorite_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:breed_challenge/core/erros/failures.dart';
import 'package:breed_challenge/features/presenter/pages/home/home_store.dart';

class MockGetDogBreedsUsecase extends Mock implements GetDogBreedsUsecase {}

class MockAddFavoriteUsecase extends Mock implements AddFavoriteUsecase {}

class MockDeleteFavoriteUsecase extends Mock implements DeleteFavoriteUsecase {}

void main() {
  late HomeStore store;
  late GetDogBreedsUsecase getDogBreedsUsecase;
  late AddFavoriteUsecase addFavoriteUsecase;
  late DeleteFavoriteUsecase deleteFavoriteUsecase;

  setUp(() {
    getDogBreedsUsecase = MockGetDogBreedsUsecase();
    addFavoriteUsecase = MockAddFavoriteUsecase();
    deleteFavoriteUsecase = MockDeleteFavoriteUsecase();
    store = HomeStore(
        getDogBreedsUsecase, addFavoriteUsecase, deleteFavoriteUsecase);
  });

  List<DogBreedEntity> tDogBreedEntityList = [
    DogBreed(breedName: 'breedName', subBreeds: []),
  ];

  test(
    'should return a DogBreed from the getDogBreedsUsecase',
    () async {
      // Arrange
      when(() => getDogBreedsUsecase.call()).thenAnswer(
        (_) async => Right(tDogBreedEntityList),
      );

      // Act
      await store.getBreeds();

      // Assert
      store.observer(
        onState: (state) {
          expect(state, tDogBreedEntityList);
          verify(() => getDogBreedsUsecase.call()).called(1);
        },
      );
    },
  );

  test(
    'should return a Failure from the getDogBreedsUsecase when not succeed',
    () async {
      // Arrange
      when(() => getDogBreedsUsecase.call()).thenAnswer(
        (_) async => Left(ServerFailure()),
      );

      // Act
      await store.getBreeds();

      // Assert
      store.observer(
        onError: (state) {
          expect(state, ServerFailure());
          verify(() => getDogBreedsUsecase.call()).called(1);
        },
      );
    },
  );
}
