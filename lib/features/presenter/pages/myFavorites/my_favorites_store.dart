import 'package:breed_challenge/features/domain/entities/dog_breed_entity.dart';
import 'package:breed_challenge/features/domain/usecases/external/get_random_breed_pictures_usecase.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:breed_challenge/core/erros/failures.dart';

class MyFavoritesStore extends NotifierStore<Failure, List<DogBreedEntity>> {
  final GetRandomBreedPicturesUsecase getRandomBreedPictures;

  MyFavoritesStore(this.getRandomBreedPictures) : super([]);

  Future<void> getBreedPictures(List<DogBreedEntity> query) async {
    setLoading(true);

    final result = await getRandomBreedPictures.call(query);

    result.fold((l) => setError(l), (r) => update(r));

    setLoading(false);
  }
}
