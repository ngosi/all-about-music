import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:all_about_music/components/diagonal_container.dart';
import 'package:all_about_music/components/page_indicator.dart';
import 'package:all_about_music/components/blur_button.dart';
import 'package:all_about_music/utils/colors.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final ScrollController _imageController = ScrollController();
  final PageController _textController = PageController();
  int _pageIndex = 0;

  final List<String> _onboardingImages = [
    'assets/images/onboarding1.png',
    'assets/images/onboarding2.png',
    'assets/images/onboarding3.png',
  ];

  final List<List<String>> _onboardingText = [
    ['The Round Table', '1. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos'],
    ['Artist Profile', '2. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos'],
    ['FAN APP', '3. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos'],
  ];

  @override
  void initState() {
    _textController.addListener(textControllerListener);
    super.initState();
  }

  void textControllerListener() {
    setState(() {
      double width = MediaQuery.of(context).size.width;
      _imageController.jumpTo(_textController.offset / (width-72) * width);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 284,
              child: ListView.builder(
                controller: _imageController,
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Image(
                    image: AssetImage(_onboardingImages[index % 3]),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topCenter,
                  );
                },
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
                child: BlurButton(() => context.go('/login')),
              ),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: DiagonalContainer(
                height: 365,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 56, right: 16),
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: PageIndicator(_pageIndex, 3),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _textController,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      onPageChanged: (index) {
                        setState(() {
                          _pageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 72,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  _onboardingText[index][0],
                                  style: const TextStyle(
                                    fontFamily: 'Cypher2',
                                    fontSize: 26,
                                    color: white,
                                  ),
                                ),
                              ),
                              Text(
                                _onboardingText[index][1],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'HelveticaNeue',
                                  fontSize: 15,
                                  height: 1.2,
                                  color: lightGrey,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 50, bottom: 30),
                    child: Text(
                      'ALLABOUTMUSIC.COM',
                      style: TextStyle(
                        fontFamily: 'Cypher1',
                        color: lightGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
