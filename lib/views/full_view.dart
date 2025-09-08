import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper/core/app_colors.dart';
import 'package:wallpaper/provider/save_img_provider.dart';

class FullView extends ConsumerStatefulWidget {   
  final String imgPath;

  FullView({required this.imgPath});

  @override
  ConsumerState<FullView> createState() => _FullViewState(); 
}

class _FullViewState extends ConsumerState<FullView> { 
  @override
  Widget build(BuildContext context,) {
     final saveState = ref.watch(saveImageProvider);
    return Scaffold(
        body: Stack(
      children: [
        Hero(
            tag: widget.imgPath,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: CachedNetworkImage(
                imageUrl: widget.imgPath,
                fit: BoxFit.cover,
              ),
            )),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(bottom: 10),
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    InkWell(
                      onTap: (){
                            ref.read(saveImageProvider.notifier).save(widget.imgPath);
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: AppColors.primary),
                            borderRadius: BorderRadius.circular(19),
                            gradient: LinearGradient(
                                colors: [AppColors.info, AppColors.primary])),
                        child: Column(
                          children: [
                            Text(
                              "Set Wallpaper",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: AppColors.textLight,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Image will be Saved in the Gallery",
                              style: TextStyle(
                                  fontSize: 15, color: AppColors.textLight),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 15, color: AppColors.textLight),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }


}
