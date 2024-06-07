import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:all_about_music/utils/colors.dart';

class SmallMusicPlayer extends StatefulWidget {
  final String songId;
  const SmallMusicPlayer(this.songId, {super.key});

  @override
  State<SmallMusicPlayer> createState() => _SmallMusicPlayerState();
}

class _SmallMusicPlayerState extends State<SmallMusicPlayer> {
  late String _title;
  late String _author;
  late String? _coverUrl;
  late String _songUrl;
  bool _isLoading = true;

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    Map<String, dynamic> snap = (await FirebaseFirestore.instance
        .collection('demos').doc(widget.songId).get()).data()!;
    _title = snap['title'];
    _author = snap['author'];
    _coverUrl = snap['coverUrl'];
    _songUrl = snap['songUrl'];
    _audioPlayer.setSourceUrl(_songUrl);
    setState(() {
      _isLoading = false;
    });
  }

  void pauseOrResume() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: purple,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.push('/song${widget.songId}'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: double.infinity,
                color: grey,
                child: _isLoading || _coverUrl == null ? null : Image(
                  image: NetworkImage(_coverUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 18),
          _isLoading
            ? const CircularProgressIndicator(color: white)
            : Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => context.push('/song${widget.songId}'),
                        child: Text(
                          _title,
                          style: const TextStyle(
                            color: white,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          _author,
                          style: const TextStyle(
                            color: grey,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  FilledButton(
                    onPressed: pauseOrResume,
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      fixedSize: const Size.fromHeight(40),
                      shape: const CircleBorder(),
                      backgroundColor: orange,
                    ),
                    child: Icon(
                      _isPlaying
                        ? Icons.pause
                        : Icons.play_arrow_rounded,
                      color: white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
