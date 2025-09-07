import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:wallpaper/core/app_colors.dart';
import 'package:wallpaper/service/database.dart';

class AddWallpaper extends StatefulWidget {
  const AddWallpaper({super.key});

  @override
  State<AddWallpaper> createState() => _AddWallpaperState();
}

class _AddWallpaperState extends State<AddWallpaper> {
  final List<String> categoryItem = ["City", "Food", "Mobile"];
  String? value;
  final ImagePicker imgPicker = ImagePicker();
  File? selectedImg;
  Future getImage() async {
    var img = await imgPicker.pickImage(source: ImageSource.gallery);
    selectedImg = File(img!.path);
    setState(() {});
  }

  addWallpaper() async {
    if (selectedImg != null) {
      String addId = randomAlphaNumeric(10);
      Reference FirebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImages").child(addId);

      final UploadTask task = FirebaseStorageRef.putFile(selectedImg!);
      var downloadUrl = await (await task).ref.getDownloadURL();

      Map<String, dynamic> addItem = {
        "Image": downloadUrl,
        "id": addId,
      };

      await DatabaseMethod().addWallpaper(addItem, addId, value!).then((val) {
        return ScaffoldMessenger(
            child: SnackBar(
                backgroundColor: AppColors.accent,
                content: Text("Image Uploaded")));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add Wallpaper",
            style: TextStyle(),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)),
        ),
        body: Container(
          child: Column(children: [
            SizedBox(
              height: 21,
            ),
            selectedImg == null
                ? InkWell(
                    onTap: () {
                      getImage();
                    },
                    child: Center(
                      child: Material(
                        elevation: 4,
                        child: Container(
                            child: Icon(Icons.camera_alt),
                            height: 300,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: AppColors.primary, width: 1.6))),
                      ),
                    ),
                  )
                : Center(
                    child: Material(
                       borderRadius: BorderRadius.circular(20),
                      elevation: 4,
                      child: Container(
                          child: Image.file(
                            selectedImg!,
                            fit: BoxFit.cover,
                          ),
                          height: 300,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppColors.primary, width: 1.6))),
                    ),
                  ),
            SizedBox(
              height: 21,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 6),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                items: categoryItem.map((item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    this.value = val;
                  });
                },
                hint: Text('select catefory'),
              )),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                addWallpaper();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 6),
                width: MediaQuery.of(context).size.width / 0.7,
                height: 50,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                  "Add",
                  style: TextStyle(fontSize: 20, color: AppColors.white),
                )),
              ),
            ),
          ]),
        ));
  }
}
