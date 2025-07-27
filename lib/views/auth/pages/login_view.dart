import 'package:chattingapp/controllers/auth_controller.dart';
import 'package:chattingapp/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController =TextEditingController();
  final _passController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();
  bool _obscurepass = true;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        padding: EdgeInsets.all(28),
        child: Form(
          key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40,),
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(Icons.chat_bubble_rounded,size: 40,color: Colors.white,),
                  ),
                ),
                SizedBox(height: 35,),
                Text("welcome Back!",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(height: 10,),
                Text('Sign in to continue chatting with friends and family',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondaryColor),
                ),
                SizedBox(height: 43),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email_outlined),
                    hintText: 'Enter your email',
                  ),
                  validator: (value){
                    if(value?.isEmpty ?? true){
                      return 'please enter your email';
                    }if(GetUtils.isEmail(value!)){
                      return 'enter a valid email';
                    }
                    return null;
                  }
                ),
                SizedBox(height: 15,),
                TextFormField(
                    controller: _passController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock_outline),
                      hintText: 'Enter your password',
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          _obscurepass = !_obscurepass;

                        });
                      }, icon: Icon(_obscurepass? Icons.visibility_outlined: Icons.visibility_off))
                    ),
                    validator: (value){
                      if(value?.isEmpty ?? true){
                        return 'please enter your password';
                      }if(value!.length<6){
                        return 'password must be at least 6 characters';
                      }
                      return null;
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
