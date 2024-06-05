import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:all_about_music/components/card.dart';
import 'package:all_about_music/components/music_player.dart';
import 'package:all_about_music/components/small_music_player.dart';
import 'package:all_about_music/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _topDemos = [];
  final List<String> _artistCardUrls = [];
  final List<String> _artistNames = [];
  final List<int> _artistFollowers = [];
  final List<String> _recentDemos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    QuerySnapshot<Map<String, dynamic>> snap = await FirebaseFirestore.instance
        .collection('demos').orderBy('votesCount', descending: true).get();
    int limit = 5;
    for (final doc in snap.docs) {
      _topDemos.add(doc.data()['songId']);
      if (limit == 0) {
        break;
      }
      limit--;
    }
    snap = await FirebaseFirestore.instance
        .collection('artists').orderBy('followerCount', descending: true).get();
    limit = 5;
    for (final doc in snap.docs) {
      _artistCardUrls.add(doc.data()['cardUrl']);
      _artistNames.add(doc.data()['stageName']);
      _artistFollowers.add(doc.data()['followerCount']);
      if (limit == 0) {
        break;
      }
      limit--;
    }
    snap = await FirebaseFirestore.instance
        .collection('demos').orderBy('timestamp', descending: true).get();
    for (final doc in snap.docs) {
      _recentDemos.add(doc.data()['songId']);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
      ? const Center(child: CircularProgressIndicator(color: white))
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
              padding: const EdgeInsets.only(left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        const Image(image: AssetImage('assets/images/logo.png'), width: 100),
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset('assets/icons/menu.svg'),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'TOP 5 DEMOS',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: white,
                      height: .75
                    ),
                  ),
                  const Divider(color: orange),
                  Text(
                    DateFormat('MMM d, y').format(DateTime.now()),
                    style: const TextStyle(
                      color: grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: .5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 260,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _topDemos.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            MusicPlayer(_topDemos[index]),
                            const SizedBox(width: 24),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Next Round Table',
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: white,
                    ),
                  ),
                  const Divider(color: orange),
                  Padding(
                    padding: const EdgeInsets.only(right: 24, top: 6),
                    child: Container(
                      width: double.infinity,
                      height: 46,
                      decoration: BoxDecoration(
                        color: const Color(0xFF191723),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: .75,
                          child: Container(
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: orange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: SvgPicture.asset('assets/icons/clock.svg'),
                                ),
                                const Text(
                                  '10:20:20',
                                  style: TextStyle(
                                    color: blueishGrey,
                                    fontSize: 20
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 6, right: 60),
                    child: Text(
                      'Vote for your favorite demos before the timer gets to the end.',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                        color: blueishGrey,
                      ),
                    ),
                  ),
                  const Divider(color: orange),
                  Padding(
                    padding: const EdgeInsets.only(right: 24, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Top 5',
                          style: TextStyle(
                            color: white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'View all',
                            style: TextStyle(
                              color: grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _artistCardUrls.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            ArtistCard(
                              cardUrl: _artistCardUrls[index],
                              artistName: _artistNames[index],
                              followerCount: _artistFollowers[index],
                            ),
                            const SizedBox(width: 24),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Discover more demo tracks',
                    style: TextStyle(
                      color: white,
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      height: 2,
                    ),
                  ),
                  const Text(
                    'What do you want to hear?',
                    style: TextStyle(
                      color: grey,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12, right: 24),
                    child: TextField(
                      controller: _searchController,
                      cursorColor: orange,
                      style: const TextStyle(
                        color: grey,
                        fontFamily: 'HelveticaNeue',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search Music',
                        hintStyle: const TextStyle(
                          color: grey,
                          fontFamily: 'HelveticaNeue',
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: purple,
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: grey,
                        // isDense: true,
                        contentPadding: const EdgeInsets.all(8),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Recently Added',
                    style: TextStyle(
                      color: white,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 32, right: 24),
                    child: Column(
                      children: _recentDemos.map((songId) {
                        int index = _recentDemos.indexOf(songId);
                        return Column(
                          children: [
                            SmallMusicPlayer(songId),
                            if (index != _recentDemos.length - 1)
                              const SizedBox(height: 12),
                          ],
                        );
                      }).toList(),
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
