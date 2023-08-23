import 'dart:convert';

import 'package:breed_challenge/features/data/models/dog_breed_model.dart';
import 'package:breed_challenge/features/domain/entities/dog_breed_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/dog_breed_mock.dart';

void main() {
  DogBreed tDogBreed = DogBreed(breedName: 'breedName', subBreeds: []);

  test('DogBreed should be of type DogBreedEntity', () {
    // Assert
    expect(tDogBreed, isA<DogBreedEntity>());
  });

  test('should return a DogBreed from a json string', () {
    final Map<String, dynamic> jsonData = json.decode(dogBreedMock);

    // Act
    final result = DogBreed.fromJson(jsonData.entries.first.key,
        List<String>.from(jsonData.entries.first.value));

    // Assert
    expect(result, isA<DogBreedEntity>());
  });
}
