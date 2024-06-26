import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:all_about_music/models/music.dart';
import 'package:all_about_music/utils/colors.dart';

class SmallMusicPlayer extends StatefulWidget {
  final Music music;
  const SmallMusicPlayer(this.music, {super.key});

  @override
  State<SmallMusicPlayer> createState() => _SmallMusicPlayerState();
}

class _SmallMusicPlayerState extends State<SmallMusicPlayer> {
  bool _isLoading = true;

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    _audioPlayer.setSourceUrl(widget.music.songUrl);
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
            onTap: () => context.push('/song/${widget.music.songId}'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: double.infinity,
                color: grey,
                child: _isLoading || widget.music.coverUrl == null ? null : AspectRatio(
                  aspectRatio: 1,
                  child: Image(
                    image: NetworkImage(widget.music.coverUrl!),
                    fit: BoxFit.cover,
                  ),
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
                        onTap: () => context.push('/song/${widget.music.songId}'),
                        child: Text(
                          widget.music.title,
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
                          widget.music.author,
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
