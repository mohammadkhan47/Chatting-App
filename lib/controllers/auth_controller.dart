import 'dart:math';

import 'package:chattingapp/models/user_model.dart';
import 'package:chattingapp/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../main.dart' as AppRoute;
import '../services/auth_service.dart';
class AuthController extends GetxController {
  final AuthService  _authService = AuthService();
  final Rx<User?> _user = Rx<User?>(null);
  final Rx<UserModel?> _usermodel = Rx<UserModel?>(null);
  final RxBool _isloading = false.obs;
  final RxString _error = ''.obs;
  final RxBool _isinitialized  = false.obs;
  User? get user => _user.value;
  UserModel? get userModel => _usermodel.value;
  bool get isLoading => _isloading.value;
  String get error => _error.value;
  bool get isAuthenticated => _user.value !=null;
  bool get isinitialized => _isinitialized.value;
  
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _user.bindStream(_authService.authStateChanges);
    ever(_user, _handleAuthStateChange);
  }

  void _handleAuthStateChange(User? user){
    if(user == null){
      if(Get.currentRoute != AppRoutes.login){
        Get.offAllNamed(AppRoutes.login);
      }
    }else{
      if(Get.currentRoute != AppRoutes.profile) {
        Get.offAllNamed(AppRoutes.profile);
      }
      }
    if(!_isinitialized.value){
      _isinitialized.value= true;
    }
    }
    void checkInitialAuthState(){
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null){
      _user.value = currentUser;
      Get.offAllNamed(AppRoutes.main);
    }else{
      Get.offAllNamed(AppRoutes.login);
    }
    _isinitialized.value = true;
    }
    Future<void> SignInWithEmailAndPaswword(String email, String password) async {
      try {
        _isloading.value = true;
        _error.value = '';

        UserModel? userModel = await _authService.signInWithEmailAndPassword(
            email, password);
        if (userModel != null) {
          _usermodel.value = userModel;
          Get.offAllNamed(AppRoutes.main);
        }
      } catch (e) {
        _error.value = e.toString();
        Get.snackbar('error', 'failed to login');
        print(e);
      }
    finally{
      _isloading.value = false;

    }
  }
  Future<void> registerWithEmailAndPaswword(String email, String password, String displayName) async {
    try {
      _isloading.value = true;
      _error.value = '';

      UserModel? userModel = await _authService.registerWithEmailAndPassword(
          email, password, displayName);
      if (userModel != null) {
        _usermodel.value = userModel;
        Get.offAllNamed(AppRoutes.main);
      }
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar('error', 'failed to create account');
      print(e);
    }
    finally{
      _isloading.value = false;
    }
  }
  Future<void> signOut() async{
    try{
      _error.value = e.toString();
      Get.snackbar('error', 'failed to sign out');
    }finally{
      _isloading.value=false;
    }
  }
  Future<void> deleteAccount() async{
    try{
      _isloading.value =true;
      await _authService.deleteAccount();
      _usermodel.value= null;
      Get.offAllNamed(AppRoutes.login);
    }catch(e){
      _error.value = e.toString();
      Get.snackbar('error', 'failed to delete Account');
    }
  }
  void clearError() {
    _error.value= '';
  }
}