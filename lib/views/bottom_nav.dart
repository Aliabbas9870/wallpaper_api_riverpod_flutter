import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/core/app_colors.dart';
import 'package:wallpaper/views/categories_view.dart';
import 'package:wallpaper/views/home_view.dart';
import 'package:wallpaper/views/search_view.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  int currentTabIndex=0;
  late List<Widget> pages;
  late HomeView home;
  late CategoriesView categories;
  late SearchView search;
late Widget currentPage;
  @override
  void initState() {
  
    home=HomeView();
    categories=CategoriesView();
    search=SearchView();
    pages=[home,categories,search];
    currentPage=home;


      // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: 
      CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: AppColors.lightGrey,
        buttonBackgroundColor: Colors.white,
        height: 60,
        index: currentTabIndex,
        items: const [
          Icon(Icons.home,size: 20,color: AppColors.primary,),
          Icon(Icons.category,size: 20,color: AppColors.primary,),
          Icon(Icons.search,size: 20,color: AppColors.primary,),
        ],
        animationDuration: const Duration(milliseconds: 500),
        onTap: (index){
          setState(() {
            currentTabIndex=index;
            currentPage=pages[index];
          });
        },
      ),
      body: pages[currentTabIndex],
    );
  }
}