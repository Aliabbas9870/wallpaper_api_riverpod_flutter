import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/models/photo_model.dart';
import 'package:wallpaper/views/full_view.dart';

Widget wallpaper(List<PhotoModel> listphoto, BuildContext context) {
  return GridView.count(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    crossAxisCount: 2,
    childAspectRatio: 0.6,
    mainAxisSpacing: 6.0,
    crossAxisSpacing: 6.0,
    children: listphoto.map((PhotoModel photomodel) {
      return GridTile(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) =>
                        FullView(imgPath: photomodel.src!.portrait! ?? "")));
          },
          child: Hero(
            tag: photomodel.src ?? "",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: photomodel.src!.portrait! ?? "",
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
      );
    }).toList(),
  );
}
