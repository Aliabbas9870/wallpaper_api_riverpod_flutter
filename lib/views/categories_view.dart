import 'package:flutter/material.dart';
import 'package:wallpaper/core/app_colors.dart';
import 'package:wallpaper/views/all_wallpaper_view.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                'Category',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) =>
                            AllWallpaperView(category: "Wallife")));
              },
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16)),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        "assets/img1.jpg",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        height: 170,
                      ),
                    ),
                    Container(
                      height: 170,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: AppColors.transparent),
                      child: Center(
                        child: Text(
                          "Wallife",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
               onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) =>
                            AllWallpaperView(category: "Food")));
              },
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16)),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        "assets/img3.jpg",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        height: 170,
                      ),
                    ),
                    Container(
                      height: 170,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: AppColors.transparent),
                      child: Center(
                        child: Text(
                          "Food",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
               onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) =>
                            AllWallpaperView(category: "Wallife")));
              },
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16)),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        "assets/img1.jpg",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        height: 170,
                      ),
                    ),
                    Container(
                      height: 170,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: AppColors.transparent),
                      child: Center(
                        child: Text(
                          "Wallife",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
