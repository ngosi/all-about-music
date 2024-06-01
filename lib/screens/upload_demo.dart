import 'dart:typed_data';

import 'package:all_about_music/utils/firebase_methods.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:all_about_music/components/button.dart';
import 'package:all_about_music/components/field.dart';
import 'package:all_about_music/utils/utils.dart';

class UploadDemoScreen extends StatefulWidget {
  const UploadDemoScreen({super.key});

  @override
  State<UploadDemoScreen> createState() => _UploadDemoScreenState();
}

class _UploadDemoScreenState extends State<UploadDemoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _demo;
  Uint8List? _cover;

  void _submit() async {
    setState(() {
      _isLoading = true;
    });
    String result = await uploadDemo(
      title: _titleController.text,
      author: _authorController.text,
      demo: _demo,
      cover: _cover,
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

  void _selectSong() async {
    _demo = await pickSong(context);
  }

  void _selectImage(BuildContext context) async {
    _cover = await pickImage(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
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
                        onTap: () => context.go('/profile'),
                        child: const Icon(Icons.arrow_back, color: Color(0xFFC25325)),
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'UPLOAD DEMO',
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
                  Field(_titleController, FieldType.custom, text: 'TITLE'),
                  Field(_authorController, FieldType.custom, text: 'AUTHOR'),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text('Upload Demo', style: TextStyle(color: Colors.white)),
                            IconButton(onPressed: () => _selectSong(), icon: const Icon(Icons.upload), color: Colors.white),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Upload Cover', style: TextStyle(color: Colors.white)),
                            IconButton(onPressed: () => _selectImage(context), icon: const Icon(Icons.upload), color: Colors.white),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Button(() => _submit(), 'Upload', isLoading: _isLoading),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
