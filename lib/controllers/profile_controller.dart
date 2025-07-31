import 'package:chattingapp/controllers/auth_controller.dart';
import 'package:chattingapp/models/user_model.dart';
import 'package:chattingapp/services/auth_service.dart';
import 'package:chattingapp/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class ProfileController extends GetxController {

  final FirestoreService _firestoreService = FirestoreService();
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final RxBool _isloading = false.obs;
  final RxBool _isediting = false.obs;
  final RxString _error = ''.obs;
  final Rx<UserModel?> _currentUser = Rx<UserModel?>(null);

  bool get isloading => _isloading.value;

  bool get isediting => _isediting.value;

  String get error => _error.value;

  UserModel? get currentuser => _currentUser.value;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    displayNameController.dispose();
    emailController.dispose();
    super.onClose();
  }

  void _loadUserData() {
    final currentUserId = _authController.user?.uid;
    if (currentUserId != null) {
      _currentUser.bindStream(_firestoreService.getUserStream(currentUserId));

      ever(_currentUser, (UserModel? user) {
        if (user != null) {
          displayNameController.text = user.displayName;
          emailController.text = user.email;
        }
      });
    }
  }

  void toggleEditing() {
    _isediting.value = !_isediting.value;

    if (!_isediting.value) {
      final user = _currentUser.value;
      if (user != null) {
        displayNameController.text = user.displayName;
        emailController.text = user.email;
      }
    }
  }

  Future<void> updateProfile() async {
    try {
      _isloading.value = true;
      _error.value = '';
      final user = _currentUser.value;
      if (user == null) return;
      final updateUser = user.copyWith(
        displayName: displayNameController.text,
      );

      await _firestoreService.updateUser(updateUser);
      _isediting.value = false;
      Get.snackbar('success', 'profile update successfully');
    } catch (e) {
      _error.value = e.toString();
      print(e.toString());
      Get.snackbar('error', "failed to update profile");
    } finally {
      _isloading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      await _authController.signOut();
    } catch (e) {
      Get.snackbar('Error', 'failed to sign out');
    }
  }

  Future<void> deleteAccount() async {
    try {
      final result = await Get.dialog<bool>(
        AlertDialog(
          title: Text('Delete Account'),
          content: Text('are you sure to delete tour account? this action cannot be undone',
          ),
          actions: [
            TextButton(onPressed: ()=> Get.back(result: false), 
              child: Text('cancel'),
            ),
            TextButton(onPressed: ()=> Get.back(result: true),
                style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
                child: Text('delete',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      );
      if(result == true){
        _isloading.value = true;
        await _authController.deleteAccount();
      }
    } catch (e) {
      Get.snackbar('Error', 'failed to delete account');
    }finally{
      _isloading.value = false;
    }
  }

  String getJoinedData(){
    final user = _currentUser.value;
    if(user == null) {
      return '';
    }
      final date = user.createAt;

      final months =[
        'jan',
        'feb',
        'mar',
        'apr',
        'may',
        'jun',
        'jul',
        'aug',
        'sep',
        'oct',
        'nov',
        'dec',
      ];
      return 'joined ${months[date.month - 1]} ${date.year}';
  }
  void clearError(){
    _error.value = '';
  }
}