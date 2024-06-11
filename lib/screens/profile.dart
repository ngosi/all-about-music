import 'dart:ui';

import 'package:all_about_music/components/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:all_about_music/components/diagonal_container.dart';
import 'package:all_about_music/components/button.dart';
import 'package:all_about_music/components/music_player.dart';
import 'package:all_about_music/utils/utils.dart';
import 'package:all_about_music/utils/colors.dart';
import 'package:all_about_music/utils/firebase_functions.dart';
import 'package:all_about_music/models/artist.dart';
import 'package:all_about_music/models/music.dart';
import 'package:all_about_music/models/user.dart' as model;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User _user;
  late Artist _artist;
  late model.User _userModel;
  late String _address;
  final List<Music> _demos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    _user = FirebaseAuth.instance.currentUser!;
    _artist = await getArtist(_user.uid);
    _userModel = await getUser(_user.uid);
    _address = _artist.state == null ? _artist.country : '${_artist.city}, ${abrevState(_artist.state!)}';
    for (final String songId in _artist.demos) {
      _demos.add(await getMusic(songId));
    }
    setState(() {
      _isLoading = false;
    });
  }

  void upload() {
    if (_demos.isEmpty) {
      context.go('/uploadDemo');
    } else {
      showSnackBar('Must be paid account to upload more demos.', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
      ? const Center(child: CircularProgressIndicator(color: white))
      : SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                image: _artist.bannerUrl != null ? DecorationImage(
                  image: NetworkImage(_artist.bannerUrl!),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ) : null,
                gradient: _artist.bannerUrl == null
                  ? const LinearGradient(
                    colors: [darkOrange, orange2],
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
                      color: white.withOpacity(.15),
                      border: const Border(
                        top: BorderSide(
                          color: grey,
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
                              _user.displayName!.toUpperCase(),
                              style: const TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w900,
                                fontSize: 24,
                                color: white,
                                height: 1.75,
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset('assets/icons/pin.svg'),
                                const SizedBox(width: 8),
                                Text(
                                  _address,
                                  style: const TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 14,
                                    color: white,
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
                        Flexible(
                          child: FittedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _artist.stageName.toUpperCase(),
                                  style: const TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: white,
                                  ),
                                ),
                                const Text(
                                  'ARTIST NAME',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 14,
                                    color: orange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Image(
                          image: AssetImage('assets/images/logo.png'),
                          width: 110,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        _artist.bio,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 12,
                          color: blueishGrey,
                        ),
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                _artist.demos.length.toString(),
                                style: const TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: lightOrange,
                                ),
                              ),
                              const Text(
                                'Demos',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 12.5,
                                  color: grey2,
                                ),
                              ),
                            ],
                          ),
                          const Expanded(
                            child: VerticalDivider(
                              color: lightOrange,
                              thickness: .75,
                            )
                          ),
                          Column(
                            children: [
                              Text(
                                _artist.followerCount.toString(),
                                style: const TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: lightOrange,
                                ),
                              ),
                              const Text(
                                'Fans',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 12.5,
                                  color: grey2,
                                ),
                              ),
                            ],
                          ),
                          const
                          Expanded(
                            child: VerticalDivider(
                              color: lightOrange,
                              thickness: .75,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                _userModel.following.length.toString(),
                                style: const
                                TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: lightOrange,
                                ),
                              ),
                              const
                              Text(
                                'Network',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 12.5,
                                  color: grey2,
                                ),
                              ),
                            ],
                          ),
                          const
                          Expanded(
                            child: VerticalDivider(
                              color: lightOrange,
                              thickness: .75,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                _artist.messages.length.toString(),
                                style: const
                                TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: lightOrange,
                                ),
                              ),
                              const
                              Text(
                                'Coach Messages',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 12.5,
                                  color: grey2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Button(
                      'Upload Demo',
                      upload,
                      fillOrange: false,
                      borderColor: lightOrange,
                      textOrange: true,
                      height: 56,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Music Demos',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        color: orange,
                      ),
                    ),
                    const Divider(color: grey),
                    Column(
                      children: _demos.map((demo) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: MusicPlayer(demo, onTap: () => context.push('/song/${demo.songId}')),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    if (_demos.isNotEmpty)
                      DottedBorder(
                        strokeWidth: 1.5,
                        dashPattern: const [10, 9],
                        color: grey,
                        radius: const Radius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Activate your Pro Account to add more demo tracks and create your digital catalog.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Button(
                                'Activate Membership',
                                () {},
                                height: 30,
                                width: 150,
                                borderColor: lightOrange,
                                borderRadius: 30,
                                fillOrange: false,
                                textOrange: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 80),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
  }
}