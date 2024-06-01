import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:all_about_music/components/diagonal_container.dart';
import 'package:all_about_music/components/button.dart';
import 'package:all_about_music/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = true;
  late String _displayName;
  late String _stageName;
  late String _bio;
  late String _address;
  String? _bannerUrl;
  late int _network;
  late int _messages;
  late int _fans;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    User user = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot<Map<String, dynamic>> snap = await FirebaseFirestore.instance
        .collection('artists').doc(user.uid).get();
    _displayName = user.displayName!.toUpperCase();
    _stageName = snap.data()!['stageName'].toString().toUpperCase();
    _bio = snap.data()!['bio'];
    _address = '${snap.data()!['city']}, ${abrevState(snap.data()!['state'])}';
    _bannerUrl = snap.data()!['image'];
    _fans = (snap.data()!['fans'] as List).length;
    _messages = (snap.data()!['messages'] as List).length;
    snap = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    _network = (snap.data()!['following'] as List).length;
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
                            const Column(
                              children: [
                                Text(
                                  '3',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFFE88B38),
                                  ),
                                ),
                                Text(
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
                        () {},
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: [Color(0xFFC15324), Color(0xFF612A12)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(.4),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Voice of the Goddess',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 17,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Text(
                                          'Fleece Marigold',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 10,
                                            color: Color(0xFFCDC5FF),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            FilledButton(
                                              onPressed: () {},
                                              style: FilledButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                visualDensity: VisualDensity.compact,
                                                fixedSize: const Size.fromHeight(50),
                                                shape: const CircleBorder(),
                                                backgroundColor: Colors.white,
                                              ),
                                              child: const Icon(
                                                Icons.play_arrow,
                                                color: Colors.black,
                                                size: 36,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  SliderTheme(
                                                    data: SliderThemeData(
                                                      trackShape: CustomTrackShape(),
                                                      thumbShape: CustomThumbShape(),
                                                      overlayShape: SliderComponentShape.noOverlay,
                                                      trackHeight: 7,
                                                      thumbColor: Colors.white,
                                                      activeTrackColor: const Color(0xFFE88B38),
                                                      inactiveTrackColor: const Color(0xFFD8E0E6),
                                                    ),
                                                    child: Slider(
                                                      onChanged: (_) {},
                                                      value: 0.33,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
                                                    child: const Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          '03:21',
                                                          style: TextStyle(
                                                            fontFamily: 'Montserrat',
                                                            fontWeight: FontWeight.w200,
                                                            fontSize: 7,
                                                            letterSpacing: 1.25,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          '05:19',
                                                          style: TextStyle(
                                                            fontFamily: 'Montserrat',
                                                            fontWeight: FontWeight.w200,
                                                            fontSize: 7,
                                                            letterSpacing: 1.25,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: [Color(0xFFC15324), Color(0xFF612A12)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(.4),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Voice of the Goddess',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 17,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Text(
                                          'Fleece Marigold',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 10,
                                            color: Color(0xFFCDC5FF),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            FilledButton(
                                              onPressed: () {},
                                              style: FilledButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                visualDensity: VisualDensity.compact,
                                                fixedSize: const Size.fromHeight(50),
                                                shape: const CircleBorder(),
                                                backgroundColor: Colors.white,
                                              ),
                                              child: const Icon(
                                                Icons.play_arrow,
                                                color: Colors.black,
                                                size: 36,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  SliderTheme(
                                                    data: SliderThemeData(
                                                      trackShape: CustomTrackShape(),
                                                      thumbShape: CustomThumbShape(),
                                                      overlayShape: SliderComponentShape.noOverlay,
                                                      trackHeight: 7,
                                                      thumbColor: Colors.white,
                                                      activeTrackColor: const Color(0xFFE88B38),
                                                      inactiveTrackColor: const Color(0xFFD8E0E6),
                                                    ),
                                                    child: Slider(
                                                      onChanged: (_) {},
                                                      value: 0.33,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
                                                    child: const Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          '03:21',
                                                          style: TextStyle(
                                                            fontFamily: 'Montserrat',
                                                            fontWeight: FontWeight.w200,
                                                            fontSize: 7,
                                                            letterSpacing: 1.25,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          '05:19',
                                                          style: TextStyle(
                                                            fontFamily: 'Montserrat',
                                                            fontWeight: FontWeight.w200,
                                                            fontSize: 7,
                                                            letterSpacing: 1.25,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: [Color(0xFFC15324), Color(0xFF612A12)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(.4),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Voice of the Goddess',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 17,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Text(
                                          'Fleece Marigold',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 10,
                                            color: Color(0xFFCDC5FF),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            FilledButton(
                                              onPressed: () {},
                                              style: FilledButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                visualDensity: VisualDensity.compact,
                                                fixedSize: const Size.fromHeight(50),
                                                shape: const CircleBorder(),
                                                backgroundColor: Colors.white,
                                              ),
                                              child: const Icon(
                                                Icons.play_arrow,
                                                color: Colors.black,
                                                size: 36,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  SliderTheme(
                                                    data: SliderThemeData(
                                                      trackShape: CustomTrackShape(),
                                                      thumbShape: CustomThumbShape(),
                                                      overlayShape: SliderComponentShape.noOverlay,
                                                      trackHeight: 7,
                                                      thumbColor: Colors.white,
                                                      activeTrackColor: const Color(0xFFE88B38),
                                                      inactiveTrackColor: const Color(0xFFD8E0E6),
                                                    ),
                                                    child: Slider(
                                                      onChanged: (_) {},
                                                      value: 0.33,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
                                                    child: const Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          '03:21',
                                                          style: TextStyle(
                                                            fontFamily: 'Montserrat',
                                                            fontWeight: FontWeight.w200,
                                                            fontSize: 7,
                                                            letterSpacing: 1.25,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          '05:19',
                                                          style: TextStyle(
                                                            fontFamily: 'Montserrat',
                                                            fontWeight: FontWeight.w200,
                                                            fontSize: 7,
                                                            letterSpacing: 1.25,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required TextDirection textDirection,
      required Offset thumbCenter,
      Offset? secondaryOffset,
      bool isDiscrete = false,
      bool isEnabled = false,
      double additionalActiveTrackHeight = 2
    }) {
    super.paint(
      context,
      offset,
      parentBox: parentBox,
      sliderTheme: sliderTheme,
      enableAnimation: enableAnimation,
      textDirection: textDirection,
      thumbCenter: thumbCenter,
      secondaryOffset: secondaryOffset,
      isDiscrete: isDiscrete,
      isEnabled: isEnabled,
      additionalActiveTrackHeight: 0,
    );
  }
}

class CustomThumbShape extends SliderComponentShape {
  static const double _thumbRadius = 10.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size.fromRadius(_thumbRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    final Paint borderPaint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    canvas.drawCircle(center, _thumbRadius-3, borderPaint);

    final Paint thumbPaint = Paint()
      ..color = const Color(0xFFC25325)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, _thumbRadius - 5, thumbPaint);
  }
}
