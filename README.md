# metubemusic
A Flutter application for Windows that allows you to download mp3 files.

## Screenshots
![Screenshot 2023-06-15 092825](https://github.com/wpinrui/metubemusic/assets/77185900/be1db549-f4e0-40d0-b4f3-a7068718a358)
![Screenshot 2023-06-15 092933](https://github.com/wpinrui/metubemusic/assets/77185900/e026f027-e9c5-4953-9faf-313273facb06)
![Screenshot 2023-06-15 092945](https://github.com/wpinrui/metubemusic/assets/77185900/6a92b44b-9d77-4575-b851-290cf73bab2c)
![Screenshot 2023-06-15 093031](https://github.com/wpinrui/metubemusic/assets/77185900/4f143e50-17f4-441e-97e1-366cfc6b0c48)

## Attribution
Application icon (and icon on the home page)
<a href="https://www.flaticon.com/free-icons/ipod" title="ipod icons">Ipod icons created by Freepik - Flaticon</a>

## Code Quality
The code quality is very poor as this was a 2 hour job. There is no documentation or unit testing, and the separation of concerns was not a concern. This is admittedly an anti-example of Flutter architecture.

## Legality
This application is a technical demonstration only. It relies on the external packages [youtube_explode_dart](https://pub.dev/packages/youtube_explode_dart) to search for the video and [youtube-dl](https://youtube-dl.org/) to download the mp3. As such, it is not intended to be used for illegal purposes and I will not provide a build of the application.

## If you do want to build
You will need to install [Visual Studio](https://visualstudio.microsoft.com/) and the [Desktop development with C++](https://docs.microsoft.com/en-us/cpp/build/vscpp-step-0-installation?view=msvc-160) workload. You will also need to install [Flutter](https://flutter.dev/docs/get-started/install) and add it to your PATH. Run `flutter doctor` to make sure everything is installed correctly, though you can safely ignore platforms other than Windows.

Once you have cloned the repository, run `flutter pub get` to install the dependencies. You can then run `flutter build windows` to build the application.
