import 'dart:typed_data';

import 'package:all_about_music/utils/utils.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:all_about_music/components/button.dart';
import 'package:all_about_music/components/field.dart';
import 'package:all_about_music/utils/firebase_methods.dart' as auth;
import 'package:image_picker/image_picker.dart';

class ArtistSignupScreen extends StatefulWidget {
  const ArtistSignupScreen({super.key});

  @override
  State<ArtistSignupScreen> createState() => _ArtistSignupScreenState();
}

class _ArtistSignupScreenState extends State<ArtistSignupScreen> {
  final TextEditingController _stageNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isLoading = false;
  String _country = "";
  String? _state;
  String? _city;
  Uint8List? _bannerImage;

  void _signUp() async {
    setState(() {
      _isLoading = true;
    });
    String result = await auth.artistSignup(
      stageName: _stageNameController.text,
      bio: _bioController.text,
      country: _country,
      state: _state,
      city: _city,
      bannerImage: _bannerImage,
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

  _selectImage(BuildContext context) async {
    ImagePicker picker = ImagePicker();
    XFile? file;
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Take a photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                _bannerImage = await pickImage(ImageSource.camera);
                setState(() {});
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Choose from gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                _bannerImage = await pickImage(ImageSource.gallery);
                setState(() {});
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Cancel'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF404041), Color(0xFF252625)],
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
                  IconButton(
                    onPressed: () => _selectImage(context),
                    icon: const Icon(Icons.upload),
                    color: Colors.white,
                  ),
                  Button(_signUp, 'Submit', isLoading: _isLoading),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
