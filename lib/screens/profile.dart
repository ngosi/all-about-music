import 'dart:ui';

import 'package:all_about_music/components/music_player.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:all_about_music/components/diagonal_container.dart';
import 'package:all_about_music/components/button.dart';
import 'package:all_about_music/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _displayName;
  late String _stageName;
  late String _bio;
  late String _address;
  String? _bannerUrl;
  late int _network;
  late int _messages;
  late int _fans;
  late List<String> _demos;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    User user = FirebaseAuth.instance.currentUser!;
    Map<String, dynamic> snap = (await FirebaseFirestore.instance
        .collection('artists').doc(user.uid).get()).data()!;
    _displayName = user.displayName!.toUpperCase();
    _stageName = snap['stageName'].toString().toUpperCase();
    _bio = snap['bio'];
    _address = '${snap['city']}, ${abrevState(snap['state'])}';
    _bannerUrl = snap['image'];
    _messages = (snap['messages'] as List).length;
    _fans = (snap['fans'] as List).length;
    _demos = List<String>.from(snap['demos']);
    snap = (await FirebaseFirestore.instance.collection('users').doc(user.uid).get()).data()!;
    _network = (snap['following'] as List).length;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
      ? const Center(child: CircularProgressIndicator(color: Colors.white))
      : Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  image: _bannerUrl != null ? DecorationImage(
                    image: NetworkImage(_bannerUrl!),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ) : null,
                  gradient: _bannerUrl == null
                    ? const LinearGradient(
                      colors: [Color(0xFF612A12), Color(0xFFC15324)],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ) : null,
                ),
              ),
              Positioned(
                top: 50,
                right: 30,
                child: SvgPicture.asset('assets/icons/menu.svg'),
              ),
              Positioned(
                top: 221,
                left: 0,
                right: 0,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.15),
                        border: const Border(
                          top: BorderSide(
                            color: Color(0xFF707070),
                          ),
                        ),
                      ),
                      height: 92,
                      child: Row(
                        children: [
                          const SizedBox(width: 130),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _displayName,
                                style: const TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                  color: Colors.white,
                                  height: 1.75,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_pin,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _address,
                                    style: const TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: SvgPicture.asset('assets/icons/gear.svg'),
                            ),
                          ),
                          const SizedBox(width: 28),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 239),
                  DiagonalContainer(
                    defaultBorder: false,
                    minHeight: MediaQuery.of(context).size.height - 239,
                    contents: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _stageName,
                                style: const TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                'ARTIST NAME',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  color: Color(0xFFC25325),
                                ),
                              ),
                            ],
                          ),
                          const Image(
                            image: AssetImage('assets/images/logo.png'),
                            width: 110,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          _bio,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 12,
                            color: Color(0xFFD8E0E6),
                          ),
                        ),
                      ),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  _demos.length.toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFFE88B38),
                                  ),
                                ),
                                const Text(
                                  'Demos',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 12.5,
                                    color: Color(0xFFA3A3A3),
                                  ),
                                ),
                              ],
                            ),
                            const Expanded(child: VerticalDivider(
                              color: Color(0xFFE88B38), thickness: .75,)),
                            Column(
                              children: [
                                Text(
                                  _fans.toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFFE88B38),
                                  ),
                                ),
                                const Text(
                                  'Fans',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 12.5,
                                    color: Color(0xFFA3A3A3),
                                  ),
                                ),
                              ],
                            ),
                            const
                            Expanded(child: VerticalDivider(
                              color: Color(0xFFE88B38), thickness: .75,)),
                            Column(
                              children: [
                                Text(
                                  _network.toString(),
                                  style: const
                                  TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFFE88B38),
                                  ),
                                ),
                                const
                                Text(
                                  'Network',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 12.5,
                                    color: Color(0xFFA3A3A3),
                                  ),
                                ),
                              ],
                            ),
                            const
                            Expanded(child: VerticalDivider(
                              color: Color(0xFFE88B38), thickness: .75,)),
                            Column(
                              children: [
                                Text(
                                  _messages.toString(),
                                  style: const
                                  TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFFE88B38),
                                  ),
                                ),
                                const
                                Text(
                                  'Coach Messages',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 12.5,
                                    color: Color(0xFFA3A3A3),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Button(
                        () => context.go('/uploadDemo'),
                        'Upload Demo',
                        fillOrange: false,
                        borderColor: const Color(0xFFE88B38),
                        textOrange: true,
                        height: 56,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Music Demos',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          color: Color(0xFFC25325),
                        ),
                      ),
                      const Divider(color: Color(0xFF707070)),
                      Column(
                        children: _demos.map((songId) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: MusicPlayer(songId),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}