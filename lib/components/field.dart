import 'dart:ui';

import 'package:flutter/material.dart';

enum FieldType { email, password, firstName, lastName, phone, stageName, bio }

class Field extends StatelessWidget {
  final TextEditingController controller;
  final FieldType type;
  const Field(this.controller, this.type, {super.key});

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
            },
            style: const TextStyle(
              fontFamily: 'Cypher1',
              color: Color(0xFF959292),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: Colors.black,
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
                              colors: [Color(0xFF3C424B), Color(0xFF252625)],
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
                      height: 23,
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
                    color: Color(0xFF707070),
                  ),
                  cursorColor: const Color(0xFFC25325),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFFC25325)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFFC25325)),
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
