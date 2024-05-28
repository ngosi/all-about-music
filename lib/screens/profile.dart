import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:all_about_music/widgets/diagonal_container.dart';
import 'package:all_about_music/widgets/button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFC15324), Color(0xFF612A12)],
            ),
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
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
