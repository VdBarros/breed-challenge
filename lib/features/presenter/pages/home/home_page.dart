import 'package:breed_challenge/features/data/models/dog_breed_model.dart';
import 'package:breed_challenge/features/domain/entities/dog_breed_entity.dart';
import 'package:breed_challenge/features/presenter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:breed_challenge/core/erros/failures.dart';
import 'package:breed_challenge/app_binding.dart';
import 'package:breed_challenge/features/presenter/pages/home/home_store.dart';
import 'package:breed_challenge/features/presenter/pages/widgets/search_bar.dart'
    as search_bar;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<DogBreedEntity> breeds = [];

class _HomePageState extends State<HomePage> {
  List<DogBreedEntity> displayedBreeds = [];

  void handleSearch(String query) {
    if (query.isNotEmpty) {
      List<DogBreedEntity> filteredList = breeds
          .where((breed) =>
              breed.breedName.toLowerCase().contains(query.toLowerCase()))
          .toList();

      setState(() {
        displayedBreeds = filteredList;
      });
    } else {
      setState(() {
        displayedBreeds = List.from(breeds);
      });
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      displayedBreeds = [];
      breeds.clear();
    });
    getIt<HomeStore>().getBreeds();
  }

  Future<void> _showSubBreedDialog(DogBreedEntity breed) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a SubBreed for ${breed.breedName}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: breed.subBreeds.map((subBreed) {
                return ListTile(
                  title: Text(subBreed),
                  onTap: () {
                    Navigator.pop(context);
                    _navigateToBreedPicturesPage(breed.breedName, subBreed);
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _navigateToBreedPicturesPage(breed.breedName, null);
              },
              child: Text('Continue with ${breed.breedName}'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToBreedPicturesPage(String breed, String? subBreed) {
    final path = subBreed != null ? '/$subBreed' : '';
    goRouter.push('/breed-pictures/$breed$path');
  }

  void _handleFavoriteToggle(DogBreedEntity breed) async {
    if (breed.isFavorite) {
      getIt<HomeStore>().deleteFavorites(breed.breedName);
    } else {
      getIt<HomeStore>().addFavorites(breed.breedName);
    }

    final updatedBreed =
        DogBreed(breedName: breed.breedName, subBreeds: breed.subBreeds);
    updatedBreed.isFavorite = !breed.isFavorite;

    setState(() {
      final updatedIndex = displayedBreeds.indexWhere(
        (item) => item.breedName == breed.breedName,
      );
      if (updatedIndex != -1) {
        displayedBreeds[updatedIndex] = updatedBreed;
      }

      final rootIndex = breeds.indexWhere(
        (item) => item.breedName == breed.breedName,
      );
      if (rootIndex != -1) {
        breeds[rootIndex] = updatedBreed;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getIt<HomeStore>().getBreeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Dog Breeds',
          style: TextStyle(
            color: Colors.black45,
          ),
        ),
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            color: Colors.amber,
            onPressed: () {
              goRouter.push('/my-favorites');
            },
          ),
        ],
      ),
      body: ScopedBuilder(
        store: getIt<HomeStore>(),
        onLoading: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        onError: (context, error) {
          if (error is EmptyParamFailure) {
            return const Center(
              child: Text(
                'Você precisa digitar alguma coisa na pesquisa!',
              ),
            );
          }
          return Center(
            child: Text('Something went wrong: $error'),
          );
        },
        onState: (context, List<DogBreedEntity> state) {
          if (breeds.isEmpty) {
            breeds = state;
            displayedBreeds = state;
          }
          return Column(
            children: [
              search_bar.SearchBar(onQueryChanged: handleSearch),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshData,
                  child: ListView.builder(
                    itemCount: displayedBreeds.length,
                    itemBuilder: (context, index) {
                      final breed = displayedBreeds[index];
                      return ListTile(
                        title: Text(breed.breedName),
                        trailing: GestureDetector(
                          onTap: () {
                            _handleFavoriteToggle(breed);
                          },
                          child: Stack(
                            children: [
                              Icon(
                                breed.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color:
                                    breed.isFavorite ? Colors.red : Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          if (breed.subBreeds.isNotEmpty) {
                            _showSubBreedDialog(breed);
                          } else {
                            _navigateToBreedPicturesPage(breed.breedName, null);
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
