import 'package:breed_challenge/core/erros/failures.dart';
import 'package:breed_challenge/features/domain/repositories/idao_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:breed_challenge/core/usecase/usecase.dart';

class DeleteFavoriteUsecase implements Usecase<void, String> {
  final IDAORepository repository;

  DeleteFavoriteUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(String query) async {
    return await repository.removeFavorite(query);
  }
}
