import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            _index = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset('assets/icons/person.svg'),
            label: '',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('assets/icons/music.svg'),
            label: '',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('assets/icons/podcast.svg'),
            label: '',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('assets/icons/settings.svg'),
            label: '',
          ),
        ],
        selectedIndex: _index,
      ),
    );
  }
}
