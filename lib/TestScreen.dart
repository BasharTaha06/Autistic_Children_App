import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TestScreen extends StatefulWidget {
  String VideoName;
  YoutubePlayerController controller;
  TestScreen({required this.controller, required this.VideoName});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text(widget.VideoName),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            YoutubePlayer(
              controller: widget.controller,
              showVideoProgressIndicator: true,
              bottomActions: [
                CurrentPosition(),
                ProgressBar(isExpanded: true),
                PlaybackSpeedButton(),
                FullScreenButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
