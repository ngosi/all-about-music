import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:all_about_music/components/diagonal_container.dart';
import 'package:all_about_music/utils/colors.dart';

class RoundtableScreen extends StatefulWidget {
  const RoundtableScreen({super.key});

  @override
  State<RoundtableScreen> createState() => _RoundtableScreenState();
}

class _RoundtableScreenState extends State<RoundtableScreen> {
  late List<String> _podcastIds;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    _podcastIds = List<String>.from((await FirebaseFirestore.instance
        .collection('global')
        .doc('podcast')
        .get()).data()!['podcastIds']);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
      ? const Center(child: CircularProgressIndicator(color: white))
      : SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/onboarding1.png'),
              fit: BoxFit.fitWidth,
              alignment: Alignment(1, -1.25),
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 24, left: 12, right: 36),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset('assets/icons/back.svg')
                      ),
                      const Image(
                        image: AssetImage('assets/images/logo.png'),
                        width: 100
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset('assets/icons/menu.svg'),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 285,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        height: 92,
                        decoration: const BoxDecoration(
                          border: Border(top: BorderSide(color: grey)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'NEXT EPISODE',
                                style: TextStyle(
                                  color: white,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8, right: 12),
                                    child: SvgPicture.asset('assets/icons/clock.svg', color: white, width: 34),
                                  ),
                                  const Text(
                                    '10:20:20',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 303),
                    DiagonalContainer(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      defaultBorder: false,
                      contents: [
                        const Text(
                          'THE ROUND TABLE',
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                            color: white,
                            fontFamily: 'Cypher1',
                            fontSize: 24,
                            height: 0,
                          ),
                        ),
                        const SizedBox(height: 18),
                      ] + List<Widget>.from(_podcastIds.map((id) {
                        YoutubePlayerController controller = YoutubePlayerController(
                          initialVideoId: id,
                          flags: const YoutubePlayerFlags(
                            controlsVisibleAtStart: true,
                            autoPlay: false,
                          ),
                        );
                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: lightOrange,
                                  width: .5,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: YoutubePlayer(
                                  controller: controller,
                                  liveUIColor: orange,
                                  progressColors: const ProgressBarColors(
                                    backgroundColor: white,
                                    playedColor: lightOrange,
                                    bufferedColor: brown,
                                    handleColor: orange,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        );
                      }).toList()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}
