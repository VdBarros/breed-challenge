import 'package:breed_challenge/features/domain/usecases/external/get_breed_pictures_usecase.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:breed_challenge/core/erros/failures.dart';

class BreedPicturesStore extends NotifierStore<Failure, List<String>> {
  final GetBreedPicturesUsecase getBreedPicturesUsecase;

  BreedPicturesStore(this.getBreedPicturesUsecase) : super([]);

  Future<void> getBreedPictures(String query) async {
    setLoading(true);

    final result = await getBreedPicturesUsecase.call(query);

    result.fold((l) => setError(l), (r) => update(r));

    setLoading(false);
  }
}
