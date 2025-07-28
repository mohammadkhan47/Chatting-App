import 'package:chattingapp/controllers/auth_controller.dart';
import 'package:chattingapp/routes/app_routes.dart';
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
                    obscureText: _obscurepass,
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
                SizedBox(height: 24,),
                Obx(
                    ()=>SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(onPressed: _authController.isLoading ? null: (){
                        if(_formKey.currentState?.validate() ?? false){
                          _authController.SignInWithEmailAndPaswword(_emailController.text.trim(), _passController.text.trim()
                          );
                        }
                      },
                          child: _authController.isLoading ? SizedBox(height: 20,width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 4,
                            ),
                          )
                              :Text('Sign In'),
                      ),
                    )
                ),
                SizedBox(height: 17,),
                Center(
                  child: TextButton(onPressed: (){
                    Get.toNamed(AppRoutes.forgotPassword);
                  },
                      child: Text('Forgot Password',
                        style: TextStyle(color: AppTheme.primaryColor),
                      )),
                ),
                SizedBox(height: 34,),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Divider(
                          color: AppTheme.borderColor,)),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('OR',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        Expanded(child: Divider(
                          color: AppTheme.borderColor,)),
                        SizedBox(height: 34),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        GestureDetector(
                          onTap: ()=> Get.toNamed(AppRoutes.register),
                          child: Text('Sign Up',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith
                              (color: AppTheme.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
