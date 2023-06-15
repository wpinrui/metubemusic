import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as path_provider;

Future<String> getMetubeDownloadPath() async {
  String desktopPath = Platform.isWindows
      ? '${Platform.environment['USERPROFILE']}\\Desktop'
      : Platform.isMacOS
          ? '${Platform.environment['HOME']}/Desktop'
          : '${Platform.environment['HOME']}/Desktop';

  return '$desktopPath/metube';
}

Future<String> downloadYoutubeDL() async {
  Directory appDirectory = await path_provider.getApplicationSupportDirectory();
  String savePath = '${appDirectory.path}/youtube-dl.exe';

  File youtubeDLFile = File(savePath);
  if (await youtubeDLFile.exists()) {
    print('youtube-dl already exists at $savePath');
    return savePath;
  }

  try {
    Uri downloadUrl = Uri.parse(
        'https://github.com/yt-dlp/yt-dlp/releases/download/2023.03.04/yt-dlp.exe');
    http.Response response = await http.get(downloadUrl);

    await youtubeDLFile.writeAsBytes(response.bodyBytes);

    print('youtube-dl downloaded successfully to $savePath');
    return savePath;
  } catch (error) {
    print('Error downloading youtube-dl: $error');
    return '';
  }
}

Future<void> downloadVideo(Map<String, String> songInfo) async {
  String youtubeDLPath = await downloadYoutubeDL();
  String downloadPath = await getMetubeDownloadPath();
  String savePath = '$downloadPath/${songInfo['title']}.mp3';

  ProcessResult result = await Process.run(
    youtubeDLPath,
    ['-x', '--audio-format', 'mp3', '-o', savePath, songInfo['url']!],
    runInShell: true,
  );
}
