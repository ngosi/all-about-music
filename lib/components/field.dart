import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:all_about_music/utils/colors.dart';

enum FieldType { email, password, firstName, lastName, phone, stageName, bio, custom }

class Field extends StatelessWidget {
  final TextEditingController controller;
  final FieldType type;
  final String? text;
  const Field(this.controller, this.type, {this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 6, top: 20),
          child: Text(
            switch (type) {
              FieldType.email => 'EMAIL',
              FieldType.password => 'PASSWORD',
              FieldType.firstName => 'FIRST NAME',
              FieldType.lastName => 'LAST NAME',
              FieldType.phone => 'PHONE',
              FieldType.stageName => 'STAGE NAME',
              FieldType.bio => 'ARTIST BIO',
              FieldType.custom => text!,
            },
            style: const TextStyle(
              fontFamily: 'Cypher1',
              color: grey3,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: black,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                              colors: [grey4, darkGrey4],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                      height: 28,
                    ),
                  ),
                ),
                TextField(
                  controller: controller,
                  keyboardType: switch (type) {
                    FieldType.email => TextInputType.emailAddress,
                    FieldType.firstName || FieldType.lastName || FieldType.stageName => TextInputType.name,
                    FieldType.phone => TextInputType.phone,
                    _ => TextInputType.text
                  },
                  maxLines: type == FieldType.bio ? 4 : 1,
                  obscureText: type == FieldType.password,
                  obscuringCharacter: '*',
                  style: const TextStyle(
                    fontFamily: 'HelveticaNeue',
                    color: grey,
                  ),
                  cursorColor: orange,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: orange),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: orange),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
