import 'package:autisticchildren/TestScreen.dart';
import 'package:autisticchildren/parent/home/logic/Home_cubit.dart';
import 'package:autisticchildren/parent/home/logic/home_state.dart';
import 'package:autisticchildren/parent/home/screen/playScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatelessWidget {
  List<String> images = [
    'assets/images/OIP.jpeg',
    'assets/images/video2.jpeg',
    'assets/images/video3.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VideosCubit()..fetchVideos(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
          centerTitle: true,
        ),
        body: BlocBuilder<VideosCubit, VideosState>(
          builder: (context, state) {
            if (state is VideosLodingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is VideosLodedState) {
              return ListView.builder(
                itemCount: state.videos.length,
                itemBuilder: (context, index) {
                  final video = state.videos[index];
                  final videoId = YoutubePlayer.convertUrlToId(video['Title']);

                  final YoutubePlayerController _controller =
                      YoutubePlayerController(
                    initialVideoId: videoId!,
                    flags: YoutubePlayerFlags(
                      autoPlay: false,
                      controlsVisibleAtStart: true,
                      enableCaption: true,
                    ),
                  );

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayScreen(
                              controller: _controller,
                              videoName: video['Name'],
                              videoDesc: video['Description'],
                              imageIndex: index,
                              videos: state.videos,
                              currentIndex: index,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade300),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54, // shadow color
                              spreadRadius: 3, // how wide the shadow spreads
                              blurRadius: 6, // softness of the shadow
                              offset: Offset(0, 3), // x and y offset
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10)),
                              child: Image.asset(
                                images[index],
                                height: 25.h,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 1.h),
                              child: Text(
                                video['Name'],
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                                textAlign: TextAlign.right,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is VideosErrorState) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
