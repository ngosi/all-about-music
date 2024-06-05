import 'package:all_about_music/screens/fan.dart';
import 'package:all_about_music/utils/firebase_methods.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:all_about_music/screens/home.dart';
import 'package:all_about_music/screens/profile.dart';
import 'package:all_about_music/screens/roundtable.dart';
import 'package:all_about_music/screens/settings.dart';
import 'package:all_about_music/utils/colors.dart';

class NavBarScreen extends StatefulWidget {
  final int initIndex;
  const NavBarScreen(this.initIndex, {super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  bool _isLoading = true;
  late int _index;
  late bool _isArtist;

  @override
  void initState() {
    super.initState();
    _index = widget.initIndex;
    isArtist().then((isArtist) {
      setState(() {
        _isArtist = isArtist;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGrey3,
      extendBody: true,
      body: _isLoading
        ? const Center(child: CircularProgressIndicator(color: white))
        : [
          _isArtist ? const ProfileScreen() : const FanScreen(),
          const HomeScreen(),
          const RoundtableScreen(),
          const SettingsScreen(),
        ][_index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1A1A1A),
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/person.svg', color: _index == 0 ? orange : null),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/music.svg', color: _index == 1 ? orange : null),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/podcast.svg', color: _index == 2 ? orange : null),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/settings.svg', color: _index == 3 ? orange : null),
            label: '',
          ),
        ],
      ),
    );
  }
}
