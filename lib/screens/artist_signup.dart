import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:csc_picker/csc_picker.dart';
import 'package:go_router/go_router.dart';

import 'package:all_about_music/components/button.dart';
import 'package:all_about_music/components/field.dart';
import 'package:all_about_music/utils/firebase_functions.dart';
import 'package:all_about_music/utils/colors.dart';
import 'package:all_about_music/utils/utils.dart';

class ArtistSignupScreen extends StatefulWidget {
  const ArtistSignupScreen({super.key});

  @override
  State<ArtistSignupScreen> createState() => _ArtistSignupScreenState();
}

class _ArtistSignupScreenState extends State<ArtistSignupScreen> {
  final TextEditingController _stageNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _followersController = TextEditingController();
  bool _isLoading = false;
  String _country = "";
  String? _state;
  String? _city;
  Uint8List? _bannerImage;
  Uint8List? _cardImage;

  void _signUp() async {
    setState(() {
      _isLoading = true;
    });
    String result = await artistSignup(
      stageName: _stageNameController.text,
      bio: _bioController.text,
      country: _country,
      state: _state,
      city: _city,
      bannerImage: _bannerImage,
      cardImage: _cardImage,
      followerCount: _followersController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (result == 'success') {
      context.go('/profile');
    } else {
      showSnackBar(result, context);
    }
  }

  void _selectBanner(BuildContext context) async {
    _bannerImage = await pickImage(context);
  }

  void _selectCard(BuildContext context) async {
    _cardImage = await pickImage(context);
  }

  @override
  void dispose() {
    _stageNameController.dispose();
    _bioController.dispose();
    _followersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [darkGrey2, darkGrey4],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
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
                  Field(_stageNameController, FieldType.stageName),
                  Field(_bioController, FieldType.bio),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: CSCPicker(
                      layout: Layout.vertical,
                      flagState: CountryFlag.DISABLE,
                      defaultCountry: CscCountry.United_States,
                      onCountryChanged: (country) {
                        setState(() {
                          _country = country;
                        });
                      },
                      onStateChanged: (state) {
                        setState(() {
                          _state = state;
                        });
                      },
                      onCityChanged: (city) {
                        setState(() {
                          _city = city;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'UPLOAD BANNER',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: grey,
                              ),
                            ),
                            IconButton(
                              onPressed: () => _selectBanner(context),
                              icon: const Icon(Icons.upload),
                              color: white,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              width: 100,
                              child: Text(
                                'UPLOAD ARTIST CARD',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: grey,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => _selectCard(context),
                              icon: const Icon(Icons.upload),
                              color: white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'How many followers does this artist have?',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _followersController,
                    style: const TextStyle(color: grey),
                  ),
                  const SizedBox(height: 24),
                  Button('Submit', _signUp, isLoading: _isLoading),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
