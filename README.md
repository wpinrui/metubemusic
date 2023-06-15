# metubemusic
A Flutter application for Windows that allows you to download mp3 files.

## Screenshots

## Attribution
Application icon (and icon on the home page)
<a href="https://www.flaticon.com/free-icons/ipod" title="ipod icons">Ipod icons created by Freepik - Flaticon</a>

## Legality
This application is a technical demonstration only. It relies on the external packages [youtube_explode_dart](https://pub.dev/packages/youtube_explode_dart) to search for the video and [youtube-dl](https://youtube-dl.org/) to download the mp3. As such, it is not intended to be used for illegal purposes and I will not provide a build of the application.

## If you do want to build
You will need to install [Visual Studio](https://visualstudio.microsoft.com/) and the [Desktop development with C++](https://docs.microsoft.com/en-us/cpp/build/vscpp-step-0-installation?view=msvc-160) workload. You will also need to install [Flutter](https://flutter.dev/docs/get-started/install) and add it to your PATH. Run `flutter doctor` to make sure everything is installed correctly, though you can safely ignore platforms other than Windows.

Once you have cloned the repository, run `flutter pub get` to install the dependencies. You can then run `flutter build windows` to build the application.