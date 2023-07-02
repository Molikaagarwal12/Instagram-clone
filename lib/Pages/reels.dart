import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class UserReel extends StatefulWidget {
  const UserReel({Key? key}) : super(key: key);

  @override
  _UserReelState createState() => _UserReelState();
}

class _UserReelState extends State<UserReel> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    final videoUrl = "https://vod-progressive.akamaized.net/exp=1688309132~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F3754%2F11%2F293771277%2F1116097190.mp4~hmac=130b95975473f51644d761033bc912ce68f71784ca94450881396e49460390fa/vimeo-prod-skyfire-std-us/01/3754/11/293771277/1116097190.mp4";
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl),
    )..initialize().then((_) {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            width: 250,
            height: 350,
            child: _videoController.value.isInitialized
                ? VideoPlayer(_videoController)
                : Container(),
          ),
        ),
      ),
    );
  }
}
