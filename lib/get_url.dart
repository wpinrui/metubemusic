// import 'package:http/http.dart' as http;
// import 'dart:convert';

// Future<List<String>> getYouTubeUrl(String songTitle,
//     {bool debug = false}) async {
//   if (debug) {
//     return ["https://www.youtube.com/watch?v=R9At2ICm4LQ", 'Feel My Rhythm'];
//   }
//   const apiKey = String.fromEnvironment('YOUTUBE_API_KEY');
//   final encodedSongTitle = Uri.encodeComponent(songTitle);
//   final url =
//       'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$encodedSongTitle&type=video&key=$apiKey';

//   final response = await http.get(Uri.parse(url));
//   if (response.statusCode == 200) {
//     final data = json.decode(response.body);
//     final items = data['items'];
//     if (items != null && items.isNotEmpty) {
//       final firstResult = items[0];
//       final videoId = firstResult['id']['videoId'];
//       final videoUrl = 'https://www.youtube.com/watch?v=$videoId';
//       final videoTitle = firstResult['snippet']['title'];
//       return [videoUrl, videoTitle];
//     } else {
//       return ['https://www.youtube.com/watch?v=tPEE9ZwTmy0', 'Shortest Video'];
//     }
//   } else {
//     print('Error getting YouTube URL: ${response.statusCode}');
//     return ['https://www.youtube.com/watch?v=tPEE9ZwTmy0', 'Shortest Video'];
//   }
// }

import 'package:youtube_explode_dart/youtube_explode_dart.dart';

Future<List<String>> getYouTubeUrl(String songTitle,
    {bool debug = false}) async {
  if (debug) {
    return ["https://www.youtube.com/watch?v=R9At2ICm4LQ", 'Feel My Rhythm'];
  }

  final youtube = YoutubeExplode();
  final searchList = await youtube.search.getVideos(songTitle);
  final video = searchList.first;
  final videoUrl = 'https://www.youtube.com/watch?v=${video.id.value}';
  final videoTitle = video.title;
  youtube.close();
  return [videoUrl, videoTitle];
}
