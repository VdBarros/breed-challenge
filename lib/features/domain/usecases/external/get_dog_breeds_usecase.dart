import 'package:breed_challenge/core/erros/failures.dart';
import 'package:breed_challenge/features/domain/entities/dog_breed_entity.dart';
import 'package:breed_challenge/features/domain/repositories/idog_breeds_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:breed_challenge/core/usecase/usecase.dart';

class GetDogBreedsUsecase implements UsecaseNoParams<List<DogBreedEntity>> {
  final IDogBreedsRepository repository;

  GetDogBreedsUsecase(this.repository);

  @override
  Future<Either<Failure, List<DogBreedEntity>>> call() async {
    return await repository.getBreeds();
  }
}
