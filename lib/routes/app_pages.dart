import 'package:chattingapp/routes/app_routes.dart';
import 'package:get/get.dart';

import '../views/auth/pages/forgot_pass_view.dart';
import '../views/auth/pages/login_view.dart';
import '../views/auth/pages/register_view.dart';
import '../views/auth/pages/splash_view.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(name: AppRoutes.splash, page: ()=> const SplashView()),
    GetPage(name: AppRoutes.login, page: ()=> const LoginView()),
    GetPage(name: AppRoutes.register, page: ()=> const RegisterView()),
  GetPage(name: AppRoutes.forgotPassword, page: ()=> const ForgotPasswordView()),
 //      binding: BindingsBuilder(() {
 //        Get.put(SplashController());
 //      }),
 //    ),
 //    GetPage(name: AppRoutes.login, page: ()=> const LoginView(),
 //      binding: BindingsBuilder(() {
 //        Get.put(LoginViewController());
 //      }),
 //    ),
 //    GetPage(name: AppRoutes.register, page: ()=> const RegisterView(),
 //      binding: BindingsBuilder(() {
 //        Get.put(RequestViewController());
 //      }),
 //    ),
 //    GetPage(name: AppRoutes.forgotPassword, page: ()=> const ForgotPasswordView(),
 //      binding: BindingsBuilder(() {
 //        Get.put(ForgotPasswordController());
 //      }),
 //    ),
 //    GetPage(name: AppRoutes.changePassword, page: ()=> const ChangePasswordView(),
 //      binding: BindingsBuilder(() {
 //        Get.put(ChangePasswordController());
 //      }),
 //    ),
 //    GetPage(name: AppRoutes.home, page: ()=> const HomeView(),
 //  binding: BindingsBuilder(() {
 //    Get.put(HomeViewController());
 //  }),
 //    ),
 //    GetPage(name: AppRoutes.main, page: ()=> const MainView(),
 //  binding: BindingsBuilder((){
 //  Get.put(MainViewController());
 //  }),
 // )
 //    GetPage(name: AppRoutes.profile, page: ()=> const ProfileView(),
 //  binding: BindingsBuilder((){
 //  Get.put(ProfileViewController());
 //  }),
 // ),
 //    GetPage(name: AppRoutes.chat,page: ()=> const ChatView(),
 //      binding: BindingsBuilder((){
 //        Get.put(ChatViewController());
 //      })
 //    ),
 //    GetPage(name: AppRoutes.usersList,page: ()=> const UserListView(),
 //      binding: BindingsBuilder((){
 //        Get.put(UserListViewController());
 //      })
 //    ),
 //    GetPage(name: AppRoutes.friends, page: ()=> const FriendView(),
 //      binding: BindingsBuilder((){
 //        Get.put(FriendViewConroller());
 //      })
 //    ),
 //    GetPage(
 //        name: AppRoutes.friendRequests, page: ()=> const FriendRequestView(),
 //      binding: BindingsBuilder((){
 //        Get.put(FriendRequestController());
 //      })
 //    ),
 //    GetPage(
 //        name: AppRoutes.notifications, page: ()=> const NotificationsView(),
 //      binding: BindingsBuilder((){
 //        Get.put(NotificationsController());
 //      })
 //    ),
  ];
}