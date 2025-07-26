import 'package:chattingapp/routes/app_routes.dart';
import 'package:chattingapp/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>  with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  @override
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2)
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _scaleAnimation = Tween(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.elasticOut)
    );
    _animationController.forward();

    // _checkAuthAndNavigate();
    //   will implement check if logged in auth controller
  }
  //   void  _checkAuthAndNavigate() async{
  //     await Future.delayed(Duration(seconds: 2));
  //     final authController = Get.put(AuthController(), permanent: true);
  //     await Future.delayed(Duration(milliseconds: 800));
  //     if(authController.isAuthenticated) {
  //       Get.offAllNamed(AppRoutes.login);
  //     }else{
  //       Get.offAllNamed(AppRoutes.login);
  //   }
  // }
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: AnimatedBuilder(animation: _animationController, builder: (context, child){
          return FadeTransition(opacity: _fadeAnimation,
            child: ScaleTransition(scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: Offset(0, 10)
                        )
                      ],
                    ),
                    child: Icon(Icons.messenger_sharp,size: 50,color: Colors.deepPurple,),
                  ),
                  SizedBox(height: 32),
                  Text('Chat App',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 32,),
                  Text("Connect with Friends Instantly",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 20,
                  ),
                  ),
                  SizedBox(height: 64),
                  CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 4,
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
