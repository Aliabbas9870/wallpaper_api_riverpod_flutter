import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wallpaper/core/app_colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  int activeIndex=0;
  List<String> images = [
    'assets/wal.jpg',
    'assets/im.jpg',
    'assets/img1.jpg',
    'assets/img2.jpg',
    'assets/img3.jpg',

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // appBar: AppBar(
      //   backgroundColor: AppColors.primary,
      //   centerTitle: true,
      //   title: Text(
      //     'Gallifier',
      //     style: TextStyle(
      //         fontWeight: FontWeight.bold, color: AppColors.lightGrey),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40,right: 15,left: 15),
          child: Column(children: [
        
                Center(
                  child: Text(
                    'Gallifier',
                    style: TextStyle(
                      fontSize: 22,
                        fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                ),
             SizedBox(height: 20,),
            CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final image = images[index];
                return buildImage(image, index);
              },
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 1.5,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1,
                aspectRatio: 16 / 9,
                initialPage: 0,

                onPageChanged: (index, reason) {
                  setState(() {
                   activeIndex=index;
                  });
                },
                enlargeStrategy: CenterPageEnlargeStrategy.height
              ),
            ),
            SizedBox(height: 20,),
            animatedIndicator(),
          ]),
        ),
      ),
    );
  }

  Widget animatedIndicator(){

    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: images.length,
      effect:SlideEffect(
        dotWidth: 10,
        dotHeight: 10,
        activeDotColor: AppColors.primary,
        dotColor: AppColors.grey
      ) ,
    );
  }

  Widget buildImage(String name, int index) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.2,
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            name,
            fit: BoxFit.cover,
          )),
    );
  }
}
