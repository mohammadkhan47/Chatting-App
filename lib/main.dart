import 'package:chattingapp/routes/app_pages.dart';
import 'package:chattingapp/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "chat app",
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      // home: SplashView(),
    );
  }
}




// this is for change branch from master to main rebase--
// git branch -d master
// # On GitHub (or use command)
// git push origin --delete master
// git checkout main
// # Step 2: Merge work from master into main
// git merge master
//
// # Step 3: Push main to GitHub
// git push origin main