import 'package:flutter/material.dart';

class ImageItem extends StatefulWidget {
  final String imageUrl;

  const ImageItem({super.key, required this.imageUrl});

  @override
  State<ImageItem> createState() => _ImageItemState();
}

class _ImageItemState extends State<ImageItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
        if (isExpanded) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Expanded Image'),
              ),
              body: Center(
                child: Hero(
                  tag: widget.imageUrl,
                  child: Image.network(widget.imageUrl),
                ),
              ),
            );
          }));
        }
      },
      child: Hero(
        tag: widget.imageUrl,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: isExpanded
              ? Image.network(widget.imageUrl)
              : Image.network(widget.imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
