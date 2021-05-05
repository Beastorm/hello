import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageViewerView extends StatelessWidget {
  String image;

//  TransformationController controller;
  ImageViewerView(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Center(
          child: Container(
            child: CachedNetworkImage(
              width: double.infinity,
              height: 420,
              fit: BoxFit.cover,
              imageUrl: image,
              placeholder: (context, url) => Image.asset(
                'assets/images/loading.gif',
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}
