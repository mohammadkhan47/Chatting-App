import 'dart:async';

import 'package:chattingapp/controllers/forgot_password.dart';
import 'package:chattingapp/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
            key: controller.formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    IconButton(onPressed: controller.goBackToLogin,
                        icon: Icon(Icons.arrow_back_ios)),
                    SizedBox(width: 8,),
                    Text("Forgot Password",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ]
                ),
                SizedBox(height: 8),
                Padding(padding: EdgeInsets.only(left: 56),
                  child: Text('Enter your email to receive a password reset link',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondaryColor),
                  ),
                ),
                SizedBox(height: 60),
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(Icons.lock_reset_rounded,
                      size: 50,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Obx((){
                  if(controller.emailSent){
                    // return _buildEmailSentContent(controller);
                    return SizedBox();
                  }else {
                    return _buildEmailForm(controller);
                  }
                })
              ],
            ),
        ),
      )),
    );
  }
  Widget _buildEmailForm(ForgotPasswordController controller){
    return Column(
      children: [
        TextFormField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email Address',
            prefixIcon: Icon(Icons.email_outlined),
            hintText: 'Enter your email address',
          ),
          validator: controller.validateEmail,
        ),
        SizedBox(height: 32,),
        Obx(()=> SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
    onPressed: controller.isloading? null: controller.sentPasswordResetEmail,
              icon: controller.isloading? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: Colors.white,
                ),
              )
                :  Icon(Icons.send),
            label: Text(controller.isloading ? 'sending...' : 'send reset link'),
          )
        )
        )
      ],
    );
  }
}
