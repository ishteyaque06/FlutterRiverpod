import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:riverpodtest/core/video_player_provider/video_player.dart';
import 'package:riverpodtest/native_ui/native_ui.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isScreenChange = false;
  final models = [
    VideoModel(
      title: "My First",
      videoData: {
        "urlString": "https://test",
        "mediaId": "",
      },
    ),
    VideoModel(
      title: "Second",
      videoData: {
        "urlString": "https://test",
        "mediaId": "",
      },
    ),
    VideoModel(
      title: "Third",
      videoData: {
        "urlString": "https://test",
        "mediaId": "",
      },
    ),
    VideoModel(
      title: "Fourth",
      videoData: {
        "urlString": "https://test",
        "mediaId": "",
      },
    ),
    VideoModel(
      title: "Fifth",
      videoData: {
        "urlString": "https://test",
        "mediaId": "",
      },
    ),
  ];
  final channel = const MethodChannel('jwplayerCallBack');
  Future<void> _getPlayerCallBack() async {
    channel.setMethodCallHandler(
      (call) async {
        switch (call.method) {
          case 'fullScreenDismiss':
            setState(() {
              isScreenChange = true;
            });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    _getPlayerCallBack();
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      ref
          .read(videoPlayerProvider.notifier)
          .updateSong(models[0].videoData['urlString'] ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return InViewNotifierList(
        scrollDirection: Axis.vertical,
        isInViewPortCondition:
            (double deltaTop, double deltaBottom, double viewPortDimension) {
          return deltaTop < (0.8 * viewPortDimension) &&
              deltaBottom > (0.8 * viewPortDimension);
        },
        itemCount: models.length,
        builder: (context, index) {
          final item = models[index];
          final urlString = ref.watch(videoPlayerProvider);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 300,
              child: InViewNotifierWidget(
                id: '$index',
                builder: (context, isInView, child) {
                  if (item.videoData['urlString'] == urlString) {
                    return JWPlayerView(
                      creationParams: item.videoData,
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        ref
                            .read(videoPlayerProvider.notifier)
                            .updateSong(item.videoData['urlString'] ?? '');
                      },
                      child: Container(
                        color: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ),
          );
        });
  }
}

class VideoModel {
  final String title;
  final Map<String, String> videoData;
  VideoModel({required this.title, required this.videoData});
}
