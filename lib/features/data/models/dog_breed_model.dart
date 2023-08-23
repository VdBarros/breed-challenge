import 'package:breed_challenge/features/domain/entities/dog_breed_entity.dart';

class DogBreed extends DogBreedEntity {
  DogBreed({required super.breedName, super.subBreeds = const []});
  factory DogBreed.fromJson(String key, List<String> value) {
    return DogBreed(
      breedName: key,
      subBreeds: value,
    );
  }
}
