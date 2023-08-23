import 'package:breed_challenge/app_binding.dart';
import 'package:breed_challenge/features/domain/entities/dog_breed_entity.dart';
import 'package:breed_challenge/features/presenter/pages/myFavorites/my_favorites_store.dart';
import 'package:breed_challenge/features/presenter/pages/widgets/image_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

class MyFavoritesPage extends StatefulWidget {
  final List<DogBreedEntity> favoriteBreeds;

  const MyFavoritesPage({Key? key, required this.favoriteBreeds})
      : super(key: key);

  @override
  State<MyFavoritesPage> createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  @override
  void initState() {
    super.initState();
    getIt<MyFavoritesStore>().getBreedPictures(widget.favoriteBreeds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Favorites')),
      body: ScopedBuilder(
        store: getIt<MyFavoritesStore>(),
        onLoading: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
        onError: (_, error) => Center(
          child: Text('Error loading favorite breeders: $error'),
        ),
        onState: (context, List<DogBreedEntity> favoriteBreeders) {
          return ListView.builder(
            itemCount: favoriteBreeders.length,
            itemBuilder: (context, index) {
              final breed = favoriteBreeders[index];
              return Card(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            breed.breedName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: breed.pictures.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ImageItem(imageUrl: breed.pictures[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
