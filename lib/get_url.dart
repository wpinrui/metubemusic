import 'package:youtube_explode_dart/youtube_explode_dart.dart';

Future<List<String>> getYouTubeUrl(String songTitle,
    {bool debug = false}) async {
  if (debug) {
    return ["https://www.youtube.com/watch?v=R9At2ICm4LQ", 'Feel My Rhythm'];
  }

  final youtube = YoutubeExplode();
  // ignore: deprecated_member_use
  final searchList = await youtube.search.getVideos(songTitle);
  final video = searchList.first;
  final videoUrl = 'https://www.youtube.com/watch?v=${video.id.value}';
  final videoTitle = video.title;
  youtube.close();
  return [videoUrl, videoTitle];
}
