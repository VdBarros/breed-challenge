import 'package:breed_challenge/app_binding.dart';
import 'package:breed_challenge/features/presenter/pages/breedpictures/breed_pictures_page.dart';
import 'package:breed_challenge/features/presenter/pages/home/home_store.dart';
import 'package:breed_challenge/features/presenter/pages/myFavorites/my_favorites_page.dart';
import 'package:go_router/go_router.dart';
import 'package:breed_challenge/features/presenter/pages/home/home_page.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/breed-pictures/:breed/:subBreed',
      builder: (context, state) {
        final breed = state.params['breed'] ?? '';
        final subBreed = state.params['subBreed'] ?? '';
        return BreedPicturesPage(breed: breed, subBreed: subBreed);
      },
    ),
    GoRoute(
      path: '/breed-pictures/:breed',
      builder: (context, state) {
        final breed = state.params['breed'] ?? '';
        return BreedPicturesPage(breed: breed, subBreed: null);
      },
    ),
    GoRoute(
      path: '/my-favorites',
      builder: (context, state) {
        final favoriteBreeds = getIt<HomeStore>().favoriteBreeds;
        return MyFavoritesPage(favoriteBreeds: favoriteBreeds);
      },
    )
  ],
);
