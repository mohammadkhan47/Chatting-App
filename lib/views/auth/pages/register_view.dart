import 'package:chattingapp/controllers/auth_controller.dart';
import 'package:chattingapp/routes/app_routes.dart';
import 'package:chattingapp/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmpassController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();
  bool _obscurepass = true;
  bool _obscureconfirmpass = true;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passController.dispose();
    _displayNameController.dispose();
    _confirmpassController.dispose();
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
                Row(
                  children: [
                    IconButton(onPressed: ()=>Get..back(), icon: Icon(Icons.arrow_back_ios)
                    ),
                    Text("Create Account",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineLarge,
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Text('Get Started with new account',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppTheme.textSecondaryColor),
                ),
                SizedBox(height: 48),
                TextFormField(
                    controller: _displayNameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Username",
                      prefixIcon: Icon(Icons.person_rounded),
                      hintText: 'Enter your username',
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'please enter your username';
                      }
                      if (!GetUtils.isUsername(value!)) {
                        return 'enter a valid username';
                      }
                      return null;
                    }
                ),
                SizedBox(height: 30,),
                TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'please enter your email';
                      }
                      if (!GetUtils.isEmail(value!)) {
                        return 'enter a valid email';
                      }
                      return null;
                    }
                ),
                SizedBox(height: 30,),
                TextFormField(
                    controller: _passController,
                    obscureText: _obscurepass,
                    decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock_outline),
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(onPressed: () {
                          setState(() {
                            _obscurepass = !_obscurepass;
                          });
                        },
                            icon: Icon(
                                _obscurepass ? Icons.visibility_outlined : Icons
                                    .visibility_off))
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'please enter your password';
                      }
                      if (value!.length < 6) {
                        return 'password must be at least 6 characters';
                      }
                      return null;
                    }
                ),
                SizedBox(height: 30),
                TextFormField(
                    controller: _confirmpassController,
                    obscureText: _obscureconfirmpass,
                    decoration: InputDecoration(
                        labelText: "Confirm Password",
                        prefixIcon: Icon(Icons.lock_outline),
                        hintText: 'confirm your password',
                        suffixIcon: IconButton(onPressed: () {
                          setState(() {
                            _obscureconfirmpass = !_obscureconfirmpass;
                          });
                        },
                            icon: Icon(
                                _obscureconfirmpass ? Icons.visibility_outlined : Icons
                                    .visibility_off))
                    ),
                    validator: (value) {
                      if(value?.isEmpty?? true){
                        return 'please confirm your password';
                      }
                      if (value!= _passController.text){
                        return 'password do not match';
                      }
                      return null;
                    }
                ),
                SizedBox(height: 24,),
                Obx(
                        () =>
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _authController.isLoading ? null : () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _authController.registerWithEmailAndPaswword(
                                    _emailController.text.trim(),
                                    _passController.text.trim(),
                                    _displayNameController.text,
                                );
                              }
                            },
                            child: _authController.isLoading ? SizedBox(
                              height: 20, width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 4,
                              ),
                            )
                                : Text('Create Account'),
                          ),
                        )
                ),
                SizedBox(height: 32),
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
                        SizedBox(height: 15,),
                        Expanded(child: Divider(
                          color: AppTheme.borderColor,),
                        ),
                        SizedBox(height: 15,),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("already have an account",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.login),
                          child: Text('Sign In',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.primaryColor,
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
        )
    );
  }
}