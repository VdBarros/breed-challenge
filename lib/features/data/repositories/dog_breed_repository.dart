import 'package:breed_challenge/features/data/datasources/external/idog_breeds_datasource.dart';
import 'package:breed_challenge/features/domain/entities/dog_breed_entity.dart';
import 'package:breed_challenge/core/erros/exceptions.dart';
import 'package:breed_challenge/core/erros/failures.dart';
import 'package:breed_challenge/features/domain/repositories/idog_breeds_repository.dart';
import 'package:dartz/dartz.dart';

class DogBreedsRepository implements IDogBreedsRepository {
  final IDogBreedsDatasource datasource;

  DogBreedsRepository(this.datasource);

  @override
  Future<Either<Failure, List<DogBreedEntity>>> getBreeds() async {
    try {
      final result = await datasource.getBreeds();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getBreedPictures(String query) async {
    try {
      final result = await datasource.getBreedPictures(query);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<DogBreedEntity>>> getRandomBreedPictures(
      List<DogBreedEntity> query) async {
    try {
      final result = await datasource.getRandomBreedPictures(query);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
