import 'package:breed_challenge/core/erros/failures.dart';
import 'package:breed_challenge/features/domain/entities/dog_breed_entity.dart';
import 'package:breed_challenge/features/domain/repositories/idog_breeds_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:breed_challenge/core/usecase/usecase.dart';

class GetRandomBreedPicturesUsecase
    implements Usecase<List<DogBreedEntity>, List<DogBreedEntity>> {
  final IDogBreedsRepository repository;

  GetRandomBreedPicturesUsecase(this.repository);

  @override
  Future<Either<Failure, List<DogBreedEntity>>> call(
      List<DogBreedEntity> query) async {
    if (query.isEmpty) {
      return Left(EmptyParamFailure());
    }
    return await repository.getRandomBreedPictures(query);
  }
}
