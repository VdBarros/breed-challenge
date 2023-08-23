import 'package:breed_challenge/features/domain/entities/dog_breed_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:breed_challenge/core/erros/failures.dart';

abstract class IDogBreedsRepository {
  Future<Either<Failure, List<DogBreedEntity>>> getBreeds();
  Future<Either<Failure, List<DogBreedEntity>>> getRandomBreedPictures(
      List<DogBreedEntity> query);
  Future<Either<Failure, List<String>>> getBreedPictures(String query);
}
