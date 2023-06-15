import 'package:flutter/material.dart';
import 'download_video.dart';
import 'get_url.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userInput = '';
  bool isRedVelvet = true;

  void setUserInput(String value) {
    setState(() {
      userInput = value;
    });
  }

  void toggleIsRedVelvet() {
    setState(() {
      isRedVelvet = !isRedVelvet;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(64.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Logo(),
                const Divider(),
                SongField(callback: setUserInput),
                const Divider(height: 16.0),
                Row(
                  children: [
                    Checkbox(
                      value: isRedVelvet,
                      onChanged: (bool? val) => toggleIsRedVelvet(),
                    ),
                    const Text(
                      'Red Velvet',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                const Divider(height: 16.0),
                DownloadButton(
                    unformattedSongTitles: userInput, isRedVelvet: isRedVelvet),
              ],
            ),
          ),
        ));
  }
}

class DownloadButton extends StatefulWidget {
  final String unformattedSongTitles;
  final bool isRedVelvet;
  const DownloadButton({
    super.key,
    required this.unformattedSongTitles,
    required this.isRedVelvet,
  });

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool isLoading = false;
  int done = 0;

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void handleClick() async {
    setLoading(true);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final List<String> listOfTitles = songTitles;
    final List<Map<String, String>> listOfUrls = [];
    for (String songTitle in songTitles) {
      String searchTitle =
          '$songTitle audio song${widget.isRedVelvet ? ' red velvet' : ''}';
      try {
        List<String> urlTitle = await getYouTubeUrl(searchTitle);
        listOfUrls.add({'title': urlTitle[1], 'url': urlTitle[0]});
        if (listOfUrls.length == listOfTitles.length) {
          for (final songInfo in listOfUrls) {
            try {
              await downloadVideo(songInfo);
            } catch (e) {
              scaffoldMessenger.hideCurrentSnackBar();
              scaffoldMessenger.showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  closeIconColor: Colors.white,
                  showCloseIcon: true,
                  content: Text(e.toString()),
                  duration: const Duration(days: 365),
                ),
              );
            } finally {
              setState(() {
                done = done + 1;
              });
            }
          }
          await Future.delayed(const Duration(seconds: 1));
          setLoading(false);
          setState(() {
            done = 0;
          });
          scaffoldMessenger.hideCurrentSnackBar();
          scaffoldMessenger.showSnackBar(
            const SnackBar(
              backgroundColor: Colors.blue,
              closeIconColor: Colors.white,
              showCloseIcon: true,
              content: Text('All downloads completed'),
              duration: Duration(days: 365),
            ),
          );
        }
      } catch (e) {
        scaffoldMessenger.hideCurrentSnackBar();
        scaffoldMessenger.showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            closeIconColor: Colors.white,
            showCloseIcon: true,
            content: Text(e.toString()),
            duration: const Duration(days: 365),
          ),
        );
        setLoading(false);
        setState(() {
          done = 0;
        });
      }
    }
  }

  List<String> get songTitles {
    return widget.unformattedSongTitles
        .split('\n')
        .map((songTitle) => songTitle.trim())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: handleClick,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
      child: isLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Text('$done / ${songTitles.length} downloaded')
              ],
            )
          : const Text('Download'),
    );
  }
}

class SongField extends StatelessWidget {
  final Function callback;
  const SongField({
    super.key,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (str) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        callback(str);
      },
      textAlignVertical: TextAlignVertical.top,
      minLines: 5,
      maxLines: 10,
      decoration: const InputDecoration(
        alignLabelWithHint: true,
        border: OutlineInputBorder(),
        labelText:
            'Enter each song title on a new line. For ambiguous song titles, include the artist name too!',
      ),
    );
  }
}

class Divider extends StatelessWidget {
  final double height;
  const Divider({
    super.key,
    this.height = 32,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('images/ipod.png', width: 100, height: 100),
        Text('metube music',
            style: TextStyle(
              fontSize: 32,
              color: Colors.grey[700],
            )),
      ],
    );
  }
}
