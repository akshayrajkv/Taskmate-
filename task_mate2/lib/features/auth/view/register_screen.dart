import 'package:flutter/material.dart';
import 'package:task_mate2/features/auth/view/widgets/custombutton.dart';
import 'package:task_mate2/features/auth/view/widgets/customtextfield.dart';
import 'package:task_mate2/features/auth/view_model/auth_viewmodel.dart';
import 'package:task_mate2/util/consts.dart';
import 'package:task_mate2/widgets/customtext.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController usernamecontroller = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  AuthViewModel _authViewModel = AuthViewModel();
  bool _obscuretext = true;
  void _toggleObcuretecxt() {
    setState(() {
      _obscuretext = !_obscuretext;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: backgroundColor,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 120,
                ),
                const Text(
                  'sign up ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.bold),
                ),
                AppSpacing.h40,
                const Customtext(text: 'User name '),
                AppSpacing.h20,
                CustomTextfield(
                  controller: usernamecontroller,
                ),
                AppSpacing.h20,
                const Customtext(text: 'Email'),
                AppSpacing.h20,
                CustomTextfield(controller: emailController),
                AppSpacing.h20,
                const Customtext(text: 'password'),
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
                const SizedBox(
                  height: 50,
                ),
                Custombutton(
                    name: 'Sing up',
                    onPressed: () async {
                      String? error = await _authViewModel.register(
                        usernamecontroller.text.trim(),
                        passwordController.text.trim(),
                        emailController.text.trim(),
                      );
                      if (error == null) {
                        print(error);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ));
                      } else {
                        print(error);
                      }
                    },
                    buttonclr: Colors.white)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
