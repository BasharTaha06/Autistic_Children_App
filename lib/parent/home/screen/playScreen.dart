import 'package:autisticchildren/parent/home/logic/Home_cubit.dart';
import 'package:autisticchildren/parent/home/logic/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayScreen extends StatefulWidget {
  final String videoName;
  final YoutubePlayerController controller;
  final String videoDesc;
  final int imageIndex;
  final List videos;
  final int currentIndex;

  const PlayScreen({
    required this.controller,
    required this.videoName,
    required this.videoDesc,
    required this.imageIndex,
    required this.videos,
    required this.currentIndex,
  });

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  bool isFullScreen = false;
  List<String> images = [
    'assets/images/OIP.jpeg',
    'assets/images/video2.jpeg',
    'assets/images/video3.jpg'
  ];

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.value.isFullScreen != isFullScreen) {
        setState(() {
          isFullScreen = widget.controller.value.isFullScreen;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: widget.controller,
            showVideoProgressIndicator: true,
            bottomActions: const [
              CurrentPosition(),
              ProgressBar(isExpanded: true),
              PlaybackSpeedButton(),
              FullScreenButton(),
            ],
          ),
          builder: (context, player) {
            return ListView(
              children: [
                player,
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: Text(
                    widget.videoName,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: Text(
                    widget.videoDesc,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Text(
                    'فيديوهات مشابهة',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl,
                  ),
                ),
                SizedBox(height: 3.h),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.videos.length,
                  itemBuilder: (context, index) {
                    if (index == widget.currentIndex) return SizedBox();

                    final video = widget.videos[index];
                    final videoId =
                        YoutubePlayer.convertUrlToId(video['Title']);
                    final controller = YoutubePlayerController(
                      initialVideoId: videoId!,
                      flags: YoutubePlayerFlags(
                        autoPlay: false,
                        mute: false,
                      ),
                    );

                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlayScreen(
                                controller: controller,
                                videoName: video['Name'],
                                videoDesc: video['Description'],
                                imageIndex: index,
                                videos: widget.videos,
                                currentIndex: index,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 10.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(10)),
                                child: Image.asset(
                                  images[index],
                                  width: 35.w,
                                  height: 100.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 5.w),
                                  child: Text(
                                    video['Name'],
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
      extendBody: true,
      floatingActionButton: isFullScreen
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
    );
  }
}
