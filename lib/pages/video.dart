import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  const Video({super.key, required this.videoUrl});
  final String videoUrl;

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          _controller.play();
          _controller.setLooping(true);
          _controller.setVolume(1.0);
          _controller.setPlaybackSpeed(1.0);
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Center(
        child:
            _isInitialized
                ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: VideoPlayer(_controller),
                        ),
                      ),
                      const SizedBox(height: 16),
                      VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        colors: VideoProgressColors(
                          playedColor: Colors.green,
                          bufferedColor: Colors.grey,
                          backgroundColor: Colors.white24,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                )
                : const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
