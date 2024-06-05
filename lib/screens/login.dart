import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:all_about_music/components/button.dart';
import 'package:all_about_music/components/field.dart';
import 'package:all_about_music/utils/utils.dart';
import 'package:all_about_music/utils/colors.dart';
import 'package:all_about_music/utils/firebase_methods.dart' as fire;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool? _rememberMe = false;

  void login() async {
    setState(() {
      _isLoading = true;
    });
    String result = await fire.login(
      email: _emailController.text,
      password: _passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (result == 'success') {
      context.go(await fire.isArtist() ? '/profile' : '/fan');
    } else {
      showSnackBar(result, context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                        onTap: () => context.go('/onboarding'),
                        child: const Icon(Icons.arrow_back, color: orange),
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'LOG IN',
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
                  Field(_emailController, FieldType.email),
                  Field(_passwordController, FieldType.password),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        Checkbox.adaptive(
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value;
                            });
                          },
                        ),
                        const Text(
                          'Remember me',
                          style: TextStyle(
                            color: grey,
                            fontFamily: 'Montserrat',
                            fontSize: 11,
                          ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Forgot Password',
                              style: TextStyle(
                                color: grey,
                                fontFamily: 'Montserrat',
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                  Button('Login', login, isLoading: _isLoading),
                  const Spacer(),
                  Button('Sign Up', () => context.go('/signup'), fillOrange: false),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
