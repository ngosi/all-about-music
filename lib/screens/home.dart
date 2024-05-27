import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:all_about_music/widgets/diagonal_container.dart';
import 'package:all_about_music/widgets/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 1100,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/rapper.png'),
              alignment: Alignment.topCenter,
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 30,
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
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Color(0xFF707070),
                            ),
                          ),
                        ),
                        height: 92,
                        child: Row(
                          children: [
                            const SizedBox(width: 130),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'LEMUEL LIND',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 24,
                                    color: Colors.white,
                                    height: 1.75,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Los Angeles, CA',
                                      style: TextStyle(
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
                                child: SvgPicture.asset(
                                    'assets/icons/gear.svg'),
                              ),
                            ),
                            const SizedBox(width: 28),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 239,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: DiagonalContainer(
                    defaultBorder: false,
                    contents: [
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'LENNS ASH',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'ARTIST NAME',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  color: Color(0xFFC25325),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Image(
                            image: AssetImage('assets/images/logo.png'),
                            width: 110,
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'With one year of experience in designing, developing customer relations skills, I am a person who can work on different projects.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 12,
                            color: Color(0xFFD8E0E6),
                          ),
                        ),
                      ),
                      const IntrinsicHeight(
                        child: Row(
                          children: [
                            Column(
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
                            Expanded(child: VerticalDivider(
                              color: Color(0xFFE88B38), thickness: .75,)),
                            Column(
                              children: [
                                Text(
                                  '429',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFFE88B38),
                                  ),
                                ),
                                Text(
                                  'Fans',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 12.5,
                                    color: Color(0xFFA3A3A3),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(child: VerticalDivider(
                              color: Color(0xFFE88B38), thickness: .75,)),
                            Column(
                              children: [
                                Text(
                                  '1257',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFFE88B38),
                                  ),
                                ),
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
                            Expanded(child: VerticalDivider(
                              color: Color(0xFFE88B38), thickness: .75,)),
                            Column(
                              children: [
                                Text(
                                  '20',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFFE88B38),
                                  ),
                                ),
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
                        borderOrange: true,
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
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
