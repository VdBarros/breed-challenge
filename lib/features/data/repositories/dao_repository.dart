import 'package:breed_challenge/features/data/datasources/local/idatabase_helper_datasource.dart';
import 'package:breed_challenge/core/erros/failures.dart';
import 'package:breed_challenge/features/domain/repositories/idao_repository.dart';
import 'package:dartz/dartz.dart';

class DAORepository implements IDAORepository {
  final IDatabaseHelperDataSource datasource;

  DAORepository(this.datasource);

  @override
  Future<Either<Failure, void>> addFavorite(String breedName) async {
    try {
      final result = await datasource.addFavorite(breedName);
      return Right(result);
    } on Exception {
      return Left(DAOFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(String breedName) async {
    try {
      final result = await datasource.removeFavorite(breedName);
      return Right(result);
    } on Exception {
      return Left(DAOFailure());
    }
  }
}
