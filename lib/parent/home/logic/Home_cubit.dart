import 'package:autisticchildren/parent/home/logic/home_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideosCubit extends Cubit<VideosState> {
  VideosCubit() : super(VideosInitState());

  void fetchVideos() async {
    emit(VideosLodingState());
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('videos').get();
      final videos = snapshot.docs.map((doc) => doc.data()).toList();
      emit(VideosLodedState(videos: videos));
    } catch (e) {
      emit(VideosErrorState(message: "فشل في تحميل الفيديوهات"));
    }
  }
}
