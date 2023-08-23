import 'package:breed_challenge/features/presenter/pages/breedpictures/breed_pictures_store.dart';
import 'package:breed_challenge/features/presenter/pages/widgets/image_item.dart';
import 'package:breed_challenge/app_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

class BreedPicturesPage extends StatefulWidget {
  final String breed;
  final String? subBreed;

  const BreedPicturesPage(
      {Key? key, required this.breed, required this.subBreed})
      : super(key: key);

  @override
  State<BreedPicturesPage> createState() => _BreedPicturesState();
}

class _BreedPicturesState extends State<BreedPicturesPage> {
  @override
  void initState() {
    super.initState();
    final path = widget.subBreed != null ? '/${widget.subBreed}' : '';
    getIt<BreedPicturesStore>().getBreedPictures('${widget.breed}$path');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.breed} ${widget.subBreed ?? ''}')),
      body: ScopedBuilder(
        store: getIt<BreedPicturesStore>(),
        onLoading: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        onError: (context, error) {
          return Center(
            child: Text('Something went wrong: $error'),
          );
        },
        onState: (context, List<String> state) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemCount: state.length,
            itemBuilder: (context, index) {
              return ImageItem(imageUrl: state[index]);
            },
          );
        },
      ),
    );
  }
}
