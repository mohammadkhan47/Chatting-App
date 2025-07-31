import 'package:chattingapp/controllers/profile_controller.dart';
import 'package:chattingapp/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController>{
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        leading: IconButton(onPressed: ()=>Get.back(), 
            icon: Icon(Icons.arrow_back)),
        actions: [
          Obx(() =>TextButton(onPressed: controller.isediting
              ? controller.toggleEditing
              : controller.toggleEditing,
              child: Text(controller.isediting ? 'Cancel' : "Edit",
                style: TextStyle(
                  color: controller.isediting
                      ? AppTheme.errorColor
                      :AppTheme.primaryColor,
                ),
              )
          ),
          ),
        ],
      ),
      body: Obx((){
        final user = controller.currentuser;
        if(user == null){
          return Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryColor,
            ),
          );
        }
        return SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppTheme.primaryColor,
                    child: user.photoUrl.isNotEmpty ? ClipOval(
                      child: Image.network(user.photoUrl,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace){
                        return _buildDefaultAvatar(user);
                        },
                      ),
                    ): _buildDefaultAvatar(user),
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
  Widget _buildDefaultAvatar(dynamic user){
    return Text(user.displayName.isNotEmpty ? user.displayName[0].toUpperCase() : '?',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 32,
      ),
    );
  }
}