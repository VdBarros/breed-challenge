class DogBreedsEndpoints {
  static String getBreedImagesUrl({String? query}) =>
      'https://dog.ceo/api/breed/$query/images';
  static String getRandomBreedImagesUrl({String? query}) =>
      'https://dog.ceo/api/breed/$query/images/random/5';
  static String getBreedsUrl = 'https://dog.ceo/api/breeds/list/all';
}
