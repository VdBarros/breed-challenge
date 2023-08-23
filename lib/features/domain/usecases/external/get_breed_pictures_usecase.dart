import 'package:breed_challenge/core/erros/failures.dart';
import 'package:breed_challenge/features/domain/repositories/idog_breeds_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:breed_challenge/core/usecase/usecase.dart';

class GetBreedPicturesUsecase implements Usecase<List<String>, String> {
  final IDogBreedsRepository repository;

  GetBreedPicturesUsecase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(String query) async {
    if (query.isEmpty) {
      return Left(EmptyParamFailure());
    }
    return await repository.getBreedPictures(query);
  }
}
