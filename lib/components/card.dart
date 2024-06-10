import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:all_about_music/utils/colors.dart';

class ArtistCard extends StatelessWidget {
  final String? cardUrl;
  final String stageName;
  final int followerCount;
  const ArtistCard({
    super.key,
    required this.cardUrl,
    required this.stageName,
    required this.followerCount
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 155,
      decoration: BoxDecoration(
        color: lightGrey,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: white,
        ),
        image: cardUrl == null ? null : DecorationImage(
          image: NetworkImage(cardUrl!),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 75,
          width: double.infinity,
          decoration: BoxDecoration(
            color: white.withOpacity(.6),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(55),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    stageName,
                    style: const TextStyle(
                      color: orange,
                      fontFamily: 'Lato',
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  '$followerCount followers',
                  style: const TextStyle(
                    color: grey,
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
