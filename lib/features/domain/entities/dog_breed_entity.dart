class DogBreedEntity {
  final String breedName;
  final List<String> subBreeds;
  bool isFavorite = false;
  List<String> pictures = [];

  DogBreedEntity({required this.breedName, required this.subBreeds});

  List<Object?> get props => [breedName, subBreeds, isFavorite, pictures];
}
