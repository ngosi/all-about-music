import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:all_about_music/utils/colors.dart';

class MusicPlayer extends StatefulWidget {
  final String songId;
  const MusicPlayer(this.songId, {super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late String _title;
  late String _author;
  late String? _coverUrl;
  bool _isLoading = true;

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isDragging = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

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
    _audioPlayer.setSourceUrl(snap['songUrl']);
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _duration = duration;
      });
    });
    _audioPlayer.onPositionChanged.listen((Duration position) {
      if (!_isDragging) {
        setState(() {
          _position = position;
        });
      }
    });
    _audioPlayer.onPlayerComplete.listen((_) {
      _stop();
      _audioPlayer.setSourceUrl(snap['songUrl']);
    });

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

  void _stop() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
      _position = Duration.zero;
    });
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  String formatTime(Duration duration) {
    String twoDigitSeconds = duration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    return "${duration.inMinutes}:$twoDigitSeconds";
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: _isLoading || _coverUrl != null ? null : const LinearGradient(
            colors: [orange2, darkOrange],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: _isLoading || _coverUrl == null ? null : DecorationImage(
            image: NetworkImage(_coverUrl!),
            fit: BoxFit.cover
          ),
        ),
        width: double.infinity,
        child: _isLoading
          ? const Center(child: CircularProgressIndicator(color: white))
          : Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7.5, sigmaY: 7.5),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: brown.withOpacity(.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _title,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 17,
                              color: white,
                            ),
                          ),
                          Text(
                            _author,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 10,
                              color: whiteishPurple,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FilledButton(
                                onPressed: pauseOrResume,
                                style: FilledButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                  fixedSize: const Size.fromHeight(50),
                                  shape: const CircleBorder(),
                                  backgroundColor: white,
                                ),
                                child: Icon(
                                  _isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                  color: black,
                                  size: 36,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: SliderTheme(
                                        data: SliderThemeData(
                                          trackShape: CustomTrackShape(),
                                          thumbShape: CustomThumbShape(),
                                          overlayShape: SliderComponentShape.noOverlay,
                                          trackHeight: 7,
                                          thumbColor: white,
                                          activeTrackColor: lightOrange,
                                          inactiveTrackColor: blueishGrey,
                                        ),
                                        child: Slider(
                                          min: 0,
                                          max: _duration.inSeconds.toDouble(),
                                          value: _position.inSeconds.toDouble(),
                                          onChanged: (value) {
                                            setState(() {
                                              _isDragging = true;
                                              _position = Duration(seconds: value.toInt());
                                            });
                                          },
                                          onChangeEnd: (value) {
                                            setState(() {
                                              _isDragging = false;
                                            });
                                            seek(Duration(seconds: value.toInt()));
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            formatTime(_position),
                                            style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w200,
                                              fontSize: 7,
                                              letterSpacing: 1.25,
                                              color: white,
                                            ),
                                          ),
                                          Text(
                                            formatTime(_duration),
                                            style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w200,
                                              fontSize: 7,
                                              letterSpacing: 1.25,
                                              color: white,
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
                ),
              ),
            ],
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
      double additionalActiveTrackHeight = 0,
    }
  ) {
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
      additionalActiveTrackHeight: additionalActiveTrackHeight,
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
    }
  ) {
    final Canvas canvas = context.canvas;

    final Paint borderPaint = Paint()
      ..color = sliderTheme.thumbColor ?? white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    canvas.drawCircle(center, _thumbRadius - 3, borderPaint);

    final Paint thumbPaint = Paint()
      ..color = orange
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, _thumbRadius - 5, thumbPaint);
  }
}
