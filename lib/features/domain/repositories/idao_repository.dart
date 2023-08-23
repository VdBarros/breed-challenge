import 'package:breed_challenge/core/erros/failures.dart';
import 'package:dartz/dartz.dart';

abstract class IDAORepository {
  Future<Either<Failure, void>> addFavorite(String breedName);
  Future<Either<Failure, void>> removeFavorite(String breedName);
}
