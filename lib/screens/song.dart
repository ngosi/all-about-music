import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:all_about_music/utils/firebase_functions.dart';
import 'package:all_about_music/utils/colors.dart';
import 'package:all_about_music/models/music.dart';
import 'package:all_about_music/components/button.dart';
import 'package:all_about_music/components/music_player.dart';

class SongScreen extends StatefulWidget {
  final String songId;
  const SongScreen(this.songId, {super.key});

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  late Music _music;
  late int _rank;
  bool? _like;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    _music = await getMusic(widget.songId);
    _rank = await getDemoRank(widget.songId);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
        ? const CircularProgressIndicator(color: white)
        : SingleChildScrollView(
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
                      child: MusicPlayer(_music)
                    ),
                    const Divider(color: orange),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        _music.votesCount.toString(),
                                        style: const TextStyle(
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: lightOrange,
                                        ),
                                      ),
                                      const Text(
                                        'Fans Votes',
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
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        _rank.toString(),
                                        style: const TextStyle(
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: lightOrange,
                                        ),
                                      ),
                                      const Text(
                                        'Rank',
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
                                    ),
                                  ),
                                  if (_music.uid != FirebaseAuth.instance.currentUser!.uid)
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (_like == true) {
                                                  _like = null;
                                                } else {
                                                  _like = true;
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              _like == true
                                                ? Icons.thumb_up
                                                : Icons.thumb_up_outlined,
                                              color: lightOrange,
                                            ),
                                          ),
                                          const Expanded(
                                            child: VerticalDivider(
                                              color: lightOrange,
                                              thickness: .75,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (_like == false) {
                                                  _like = null;
                                                } else {
                                                  _like = false;
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              _like == false
                                                ? Icons.thumb_down
                                                : Icons.thumb_down_outlined,
                                              color: lightOrange,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                              ),
                            ),
                          ),
                          if (_music.uid == FirebaseAuth.instance.currentUser!.uid)
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
                          Text(
                            _music.title,
                            style: const TextStyle(
                              color: white,
                              fontFamily: 'Lato',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              height: 2
                            ),
                          ),
                          Text(
                            _music.description,
                            style: const TextStyle(
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
