import 'package:chattingapp/controllers/profile_controller.dart';
import 'package:chattingapp/theme/app_theme.dart';
import 'package:flutter/material.dart';
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
                  SizedBox(height: 16),
                  Text(user.email,
                    style: Theme.of(context!).textTheme.headlineSmall?.copyWith(color: AppTheme.textSecondaryColor),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4,horizontal: 12),
                    decoration: BoxDecoration(
                      color: user.isOnline?AppTheme.successColor.withOpacity(0.1)
                          :AppTheme.textSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            color: user.isOnline? AppTheme.successColor:
                                AppTheme.textSecondaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 6,),
                        Text(user.isOnline? 'online':'offline',
                          style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
                              color: user.isOnline?AppTheme.successColor
                                  :AppTheme.textSecondaryColor,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(controller.getJoinedData(),style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondaryColor
                  ),
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