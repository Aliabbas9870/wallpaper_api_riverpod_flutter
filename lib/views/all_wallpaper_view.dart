import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/core/app_colors.dart';
import 'package:wallpaper/service/database.dart';

class AllWallpaperView extends StatefulWidget {
  String category;
  AllWallpaperView({super.key, required this.category});

  @override
  State<AllWallpaperView> createState() => _AllWallpaperViewState();
}

class _AllWallpaperViewState extends State<AllWallpaperView> {
  Stream? categoryStream;

  getonTheLoad()async{
    categoryStream=await DatabaseMethod().getCategory(widget.category);
    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    getonTheLoad();
  }

  Widget allWallpaper() {
    return StreamBuilder(
        stream: categoryStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 6.0,
                      mainAxisSpacing: 6.0),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return CachedNetworkImage(
                      imageUrl: ds["Image"],
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url
                      , error) =>
                          Icon(Icons.error, color: AppColors.accent
                          ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
             Column(children: [
      Center(
        child: Text(
          widget.category,
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primary),
        ),
      ),
      SizedBox(
        height: 20,
      ),

      Expanded(child: allWallpaper()),
    ]));
  }
}
