import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper/core/app_colors.dart';
import 'package:wallpaper/views/bottom_nav.dart';
 final Provider = StateProvider<bool>((ref) {
  return false;
});

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> with TickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
 
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
_animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutQuart,
    );

Future.delayed(Duration(seconds: 3), () {
  ref.read(Provider.notifier).state=true;
     
      
    });
  

  }
  @override
  Widget build(BuildContext context,) {
    final splashDone = ref.watch(Provider);
    if(splashDone){
      return BottomNav();
    }
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.primary,
        child: Column(  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale:   _animation,
              
              child: Icon(Icons.wallpaper, size: 100, color: AppColors.white,)),
            SizedBox(height: 20,),
            ScaleTransition(

           scale:    _animation,
              child: Text("Wallpaper App", style: TextStyle(fontSize: 24, color: AppColors.white, fontWeight: FontWeight.bold),))
          ],
        ),
      ),
    );
  }
}