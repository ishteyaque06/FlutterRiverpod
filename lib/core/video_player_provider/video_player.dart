import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'video_player.g.dart';

@riverpod
class VideoPlayer extends _$VideoPlayer {
  @override
  String? build() {
    return null;
  }

  void updateSong(String song_url) {
    state = song_url;
  }
}
