import 'package:flutter/material.dart';

class ImageCardWidget extends StatelessWidget {
  const ImageCardWidget({super.key, required this.imgurl});

  final String imgurl;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.only(right: 16),
      elevation: 10,
      child: Container(
        height: 150,
        width: 120,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imgurl),
          ),
        ),
      ),
    );
  }
}
