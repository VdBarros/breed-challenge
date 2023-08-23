abstract class IDatabaseHelperDataSource {
  Future<List<String>> getFavorites();
  Future<void> addFavorite(String breedName);
  Future<void> removeFavorite(String breedName);
}
