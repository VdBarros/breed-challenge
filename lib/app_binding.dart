import 'package:breed_challenge/features/data/datasources/external/dog_datasource.dart';
import 'package:breed_challenge/features/data/datasources/local/database_helper_datasource.dart';
import 'package:breed_challenge/features/data/repositories/dao_repository.dart';
import 'package:breed_challenge/features/data/repositories/dog_breed_repository.dart';
import 'package:breed_challenge/features/domain/usecases/external/get_breed_pictures_usecase.dart';
import 'package:breed_challenge/features/domain/usecases/external/get_dog_breeds_usecase.dart';
import 'package:breed_challenge/features/domain/usecases/external/get_random_breed_pictures_usecase.dart';
import 'package:breed_challenge/features/domain/usecases/favorites/add_favorite_usecase.dart';
import 'package:breed_challenge/features/domain/usecases/favorites/delete_favorite_usecase.dart';
import 'package:breed_challenge/features/presenter/pages/breedpictures/breed_pictures_store.dart';
import 'package:breed_challenge/features/presenter/pages/myFavorites/my_favorites_store.dart';
import 'package:get_it/get_it.dart';
import 'package:breed_challenge/core/http/http_client.dart';
import 'package:breed_challenge/features/presenter/pages/home/home_store.dart';

final getIt = GetIt.instance;

void setUpBinding() {
  getIt.registerLazySingleton<MyFavoritesStore>(
    () => MyFavoritesStore(getIt.get<GetRandomBreedPicturesUsecase>()),
  );

  getIt.registerLazySingleton<GetRandomBreedPicturesUsecase>(
    () => GetRandomBreedPicturesUsecase(getIt.get<DogBreedsRepository>()),
  );

  getIt.registerLazySingleton<BreedPicturesStore>(
    () => BreedPicturesStore(getIt.get<GetBreedPicturesUsecase>()),
  );

  getIt.registerLazySingleton<GetBreedPicturesUsecase>(
    () => GetBreedPicturesUsecase(getIt.get<DogBreedsRepository>()),
  );

  getIt.registerLazySingleton<HomeStore>(
    () => HomeStore(getIt.get<GetDogBreedsUsecase>(),
        getIt.get<AddFavoriteUsecase>(), getIt.get<DeleteFavoriteUsecase>()),
  );

  getIt.registerLazySingleton<GetDogBreedsUsecase>(
    () => GetDogBreedsUsecase(getIt.get<DogBreedsRepository>()),
  );

  getIt.registerLazySingleton<AddFavoriteUsecase>(
    () => AddFavoriteUsecase(getIt.get<DAORepository>()),
  );

  getIt.registerLazySingleton<DeleteFavoriteUsecase>(
    () => DeleteFavoriteUsecase(getIt.get<DAORepository>()),
  );

  getIt.registerLazySingleton<DAORepository>(
    () => DAORepository(getIt.get<DatabaseHelperDataSource>()),
  );

  getIt.registerLazySingleton<DogBreedsRepository>(
    () => DogBreedsRepository(getIt.get<DogDatasource>()),
  );

  getIt.registerLazySingleton<DogDatasource>(
    () => DogDatasource(
      getIt.get<HttpClient>(),
      getIt.get<DatabaseHelperDataSource>(),
    ),
  );

  getIt.registerLazySingleton<DatabaseHelperDataSource>(
    () => DatabaseHelperDataSource.instance,
  );

  getIt.registerLazySingleton<HttpClient>(
    () => HttpClient(),
  );
}
