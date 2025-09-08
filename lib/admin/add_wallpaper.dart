import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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
  final List<String> categoryItem = ["City", "Food", "Mobile", "Wallife"];
  String? value;
  final ImagePicker imgPicker = ImagePicker();

  File? selectedImg;      // For Android/iOS
  Uint8List? webImage;    // For Web
  bool isLoading = false; // Loader flag

  Future getImage() async {
    var img = await imgPicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      if (kIsWeb) {
        webImage = await img.readAsBytes();
      } else {
        selectedImg = File(img.path);
      }
      setState(() {});
    }
  }

  Future addWallpaper() async {
    if ((selectedImg == null && webImage == null) || value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select image and category")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      String addId = randomAlphaNumeric(10);
      Reference ref =
          FirebaseStorage.instance.ref().child("blogImages").child(addId);

      UploadTask uploadTask;
      if (kIsWeb) {
        uploadTask = ref.putData(webImage!);
      } else {
        uploadTask = ref.putFile(selectedImg!);
      }

      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();

      Map<String, dynamic> addItem = {
        "Image": downloadUrl,
        "id": addId,
        "category": value,
        "createdAt": FieldValue.serverTimestamp(),
      };

      await DatabaseMethod().addWallpaper(addItem, addId, value!);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Image Uploaded Successfully")),
      );

      // Reset after upload
      setState(() {
        selectedImg = null;
        webImage = null;
        value = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Wallpaper"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 21),
                  (selectedImg == null && webImage == null)
                      ? InkWell(
                          onTap: getImage,
                          child: Center(
                            child: Material(
                              elevation: 4,
                              child: Container(
                                height: 300,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.primary,
                                    width: 1.6,
                                  ),
                                ),
                                child: const Icon(Icons.camera_alt),
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            elevation: 4,
                            child: Container(
                              height: 300,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 1.6,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: kIsWeb
                                    ? Image.memory(webImage!, fit: BoxFit.cover)
                                    : Image.file(selectedImg!,
                                        fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 21),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: value,
                        items: categoryItem.map((item) {
                          return DropdownMenuItem(
                              value: item, child: Text(item));
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            value = val;
                          });
                        },
                        hint: const Text('Select category'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: addWallpaper,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: MediaQuery.of(context).size.width / 0.7,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:isLoading
          ? const Center(child: CircularProgressIndicator())
          :  Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
