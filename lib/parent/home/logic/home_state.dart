abstract class VideosState {}

class VideosInitState extends VideosState {}

class VideosLodingState extends VideosState {}

class VideosLodedState extends VideosState {
  final List<Map<String, dynamic>> videos;
  VideosLodedState({required this.videos});
}

class VideosErrorState extends VideosState {
  String message;
  VideosErrorState({required this.message});
}
