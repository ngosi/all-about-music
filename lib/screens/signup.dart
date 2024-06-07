import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:all_about_music/components/button.dart';
import 'package:all_about_music/components/field.dart';
import 'package:all_about_music/utils/colors.dart';
import 'package:all_about_music/utils/utils.dart';
import 'package:all_about_music/utils/firebase_methods.dart' as fire;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  bool _isLoading = false;

  void signUp() async {
    setState(() {
      _isLoading = true;
    });
    String result = await fire.signUp(
      email: _emailController.text,
      password: _passwordController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (result == 'success') {
      context.go('/accountType');
    } else {
      showSnackBar(result, context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [darkGrey2, darkGrey4],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () => context.go('/login'),
                        child: const Icon(Icons.arrow_back, color: orange),
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40).copyWith(bottom: 20),
                    child: const Stack(
                      children: [
                        Image(image: AssetImage('assets/images/logo.png')),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              'AllAboutMusic.com',
                              style: TextStyle(
                                fontFamily: 'Cypher1',
                                color: grey3,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Field(_firstNameController, FieldType.firstName),
                  Field(_lastNameController, FieldType.lastName),
                  Field(_emailController, FieldType.email),
                  Field(_passwordController, FieldType.password),
                  const SizedBox(height: 48),
                  Button('Sign Up', signUp, isLoading: _isLoading),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
