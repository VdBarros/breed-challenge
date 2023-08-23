import 'package:breed_challenge/features/domain/entities/dog_breed_entity.dart';
import 'package:breed_challenge/features/domain/usecases/external/get_dog_breeds_usecase.dart';
import 'package:breed_challenge/features/domain/usecases/favorites/add_favorite_usecase.dart';
import 'package:breed_challenge/features/domain/usecases/favorites/delete_favorite_usecase.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:breed_challenge/core/erros/failures.dart';

class HomeStore extends NotifierStore<Failure, List<DogBreedEntity>> {
  final GetDogBreedsUsecase getDogBreedsUsecase;
  final AddFavoriteUsecase addFavoriteUsecase;
  final DeleteFavoriteUsecase deleteFavoriteUsecase;

  HomeStore(this.getDogBreedsUsecase, this.addFavoriteUsecase,
      this.deleteFavoriteUsecase)
      : super([]);

  Future<void> getBreeds() async {
    setLoading(true);

    final result = await getDogBreedsUsecase.call();

    result.fold((l) => setError(l), (r) => update(r));

    setLoading(false);
  }

  Future<void> getFavorites() async {
    getBreeds();
  }

  Future<void> addFavorites(String query) async {
    await addFavoriteUsecase.call(query);
  }

  Future<void> deleteFavorites(String query) async {
    await deleteFavoriteUsecase.call(query);
  }

  List<DogBreedEntity> get favoriteBreeds =>
      state.where((breed) => breed.isFavorite).toList();
}
