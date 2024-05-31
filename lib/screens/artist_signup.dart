import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:all_about_music/components/button.dart';
import 'package:all_about_music/components/field.dart';
import 'package:all_about_music/utils/firebase_methods.dart' as auth;

class ArtistSignupScreen extends StatefulWidget {
  const ArtistSignupScreen({super.key});

  @override
  State<ArtistSignupScreen> createState() => _ArtistSignupScreenState();
}

class _ArtistSignupScreenState extends State<ArtistSignupScreen> {
  final TextEditingController _stageNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isLoading = false;
  String country = "";
  String? state;
  String? city;

  void signUp() async {
    setState(() {
      _isLoading = true;
    });
    String result = await auth.artistSignup(
      stageName: _stageNameController.text,
      bio: _bioController.text,
      country: country,
      state: state,
      city: city,
    );
    setState(() {
      _isLoading = false;
    });
    if (result == 'success') {
      context.go('/profile');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _stageNameController.dispose();
    _bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF404041), Color(0xFF252625)],
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
                        child: const Icon(Icons.arrow_back, color: Color(0xFFC25325)),
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFFC25325),
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
                                color: Color(0xFF959292),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Field(_stageNameController, FieldType.stageName),
                  Field(_bioController, FieldType.bio),
                  const Spacer(),
                  CSCPicker(
                    layout: Layout.vertical,
                    flagState: CountryFlag.DISABLE,
                    onCountryChanged: (country) {
                      setState(() {
                        this.country = country;
                      });
                    },
                    onStateChanged: (state) {
                      setState(() {
                        this.state = state;
                      });
                    },
                    onCityChanged: (city) {
                      setState(() {
                        this.city = city;
                      });
                    },
                  ),
                  const Spacer(),
                  Button(signUp, 'Submit', isLoading: _isLoading),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
