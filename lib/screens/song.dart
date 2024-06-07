import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:all_about_music/components/button.dart';
import 'package:all_about_music/components/music_player.dart';
import 'package:all_about_music/utils/colors.dart';

class SongScreen extends StatelessWidget {
  final String songId;
  const SongScreen(this.songId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [orange, darkGrey3],
              center: Alignment.topCenter,
              radius: 1,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => GoRouter.of(context).pop(),
                          child: SvgPicture.asset('assets/icons/back.svg')
                        ),
                        const Image(image: AssetImage('assets/images/logo.png'), width: 100),
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset('assets/icons/menu.svg'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                    child: MusicPlayer(songId)
                  ),
                  const Divider(color: orange),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 3,
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '429',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: lightOrange,
                                      ),
                                    ),
                                    Text(
                                      'Fans Votes',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 12.5,
                                        color: grey2,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: VerticalDivider(
                                    color: lightOrange,
                                    thickness: .75,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '20',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: lightOrange,
                                      ),
                                    ),
                                    Text(
                                      'Rank',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 12.5,
                                        color: grey2,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: VerticalDivider(
                                    color: lightOrange,
                                    thickness: .75,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Button(
                            'Submit for Review',
                            () {},
                            height: 55,
                            borderRadius: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: orange),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Under review',
                              style: TextStyle(
                                color: white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            const Text(
                              '2/11/23',
                              style: TextStyle(
                                color: white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Voice of the Goddess',
                          style: TextStyle(
                            color: white,
                            fontFamily: 'Lato',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 2
                          ),
                        ),
                        const Text(
                          'Lorem ipsum o or sit amet, consectetur adipiscing elit. Nibh consectetur aliquam accumsan vel faucibus molestie- Dui molestie imperdiet malesuada a, viverra massa. Orci leo nisl tortor pulvinar tincidunt massa, at cursus. Nec pretium netus gravida proin non aliquam.',
                          style: TextStyle(
                            color: lightGrey,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 12),
                  const Divider(color: orange),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Recent Producers Feedback',
                          style: TextStyle(
                            color: white,
                            fontFamily: 'Lato',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Container(
                          height: 110,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: const AspectRatio(
                                  aspectRatio: 1,
                                  child: Image(
                                    image: AssetImage('assets/images/artist.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '10/20/23',
                                      style: TextStyle(
                                        color: grey,
                                      ),
                                    ),
                                    Text('Producer Name'),
                                    Spacer(),
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      "He's used his growing platform to advocate for youth empowerment and stuff",
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Container(
                          height: 110,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: const AspectRatio(
                                  aspectRatio: 1,
                                  child: Image(
                                    image: AssetImage('assets/images/artist.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '10/20/23',
                                      style: TextStyle(
                                        color: grey,
                                      ),
                                    ),
                                    Text('Producer Name'),
                                    Spacer(),
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      "He's used his growing platform to advocate for youth empowerment and stuff",
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Container(
                          height: 110,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: const AspectRatio(
                                  aspectRatio: 1,
                                  child: Image(
                                    image: AssetImage('assets/images/artist.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '10/20/23',
                                      style: TextStyle(
                                        color: grey,
                                      ),
                                    ),
                                    Text('Producer Name'),
                                    Spacer(),
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      "He's used his growing platform to advocate for youth empowerment and stuff",
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Container(
                          height: 110,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: const AspectRatio(
                                  aspectRatio: 1,
                                  child: Image(
                                    image: AssetImage('assets/images/artist.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '10/20/23',
                                      style: TextStyle(
                                        color: grey,
                                      ),
                                    ),
                                    Text('Producer Name'),
                                    Spacer(),
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      "He's used his growing platform to advocate for youth empowerment and stuff",
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: grey,
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
