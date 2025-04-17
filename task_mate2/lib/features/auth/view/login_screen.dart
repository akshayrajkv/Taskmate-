import 'package:flutter/material.dart';
import 'package:task_mate2/features/auth/view/register_screen.dart';
import 'package:task_mate2/features/auth/view/widgets/custombutton.dart';
import 'package:task_mate2/features/auth/view/widgets/customtextfield.dart';
import 'package:task_mate2/features/auth/view_model/auth_viewmodel.dart';
import 'package:task_mate2/util/consts.dart';
import 'package:task_mate2/widgets/customtext.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  AuthViewModel authViewModel = AuthViewModel();

  bool _obscuretext = true;
  void _toggleObcuretecxt() {
    setState(() {
      _obscuretext = !_obscuretext;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: backgroundColor,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height / 9,
                  ),
                  const Text(
                    'Log in ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.bold),
                  ),
                 AppSpacing.h20,
                  const Customtext(text: 'Email'),
                AppSpacing.h10,
                  CustomTextfield(
                    controller: emailController,
                  ),
                AppSpacing.h20,
                  const Customtext(text: 'Password'),
                 AppSpacing.h20,
                  CustomTextfield(
                    obscuretext: _obscuretext,
                    controller: passwordController,
                    suffixicon:
                        _obscuretext ? Icons.visibility_off : Icons.visibility,
                    ontap: () {
                      _toggleObcuretecxt();
                    },
                  ),
                 AppSpacing.h45,
                  Custombutton(
                      buttonclr: Colors.white,
                      name: 'Login',
                      onPressed: () async {
                        if (emailController.text.isEmpty &&
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Enter email address and password',
                              style: TextStyle(color: Colors.red),
                            ),
                            backgroundColor: Colors.white,
                          ));
                        } else if (emailController.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Enter Email',
                              style: TextStyle(color: Colors.red),
                            ),
                            backgroundColor: Colors.white,
                          ));
                        } else if (passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: Text(
                            'Enter Password',
                            style: TextStyle(color: Colors.red),
                          )));
                        } else {
                          String? error = await authViewModel.login(
                              emailController.text.trim(),
                              passwordController.text.trim());
                          if (error == null) {
                            Navigator.pushNamed(context, '/homescreen');
                          } else {
                            print(error);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'not registered',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            );
                          }
                        }
                      }),
                AppSpacing.h30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Forgotpass(),));
                          },
                          child: const Customtext(
                            text: 'Forgot password?',
                            color: Colors.white,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: height / 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Customtext(
                        text: "Don't have an account?",
                        size: 18,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(),
                              ));
                        },
                        child: const Customtext(
                          text: 'Sing up',
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
