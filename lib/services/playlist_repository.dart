import 'package:audio_demo/database/audio_entity.dart';
import 'package:audio_demo/database/table_audio.dart';
import 'package:flutter/foundation.dart';

abstract class PlaylistRepository {
  Future<List<Map<String, String>>> fetchInitialPlaylist();

  Future<Map<String, String>> fetchAnotherSong();
}

class DemoPlaylist extends PlaylistRepository {
  var _songIndex = 0;
  static const _maxSongNumber = 16;

  @override
  Future<List<Map<String, String>>> fetchInitialPlaylist(
      {int limit = 3}) async {
    List<Map<String, String>> list = [];

    try {
      List<AudioEntity> audioEntityList = await TableAudio.selectAll(
        limit: limit,
      );

      for (var el in audioEntityList) {
        list.add(el.toStringMap());
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return list;
  }

  @override
  Future<Map<String, String>> fetchAnotherSong() async {
    return await _nextSong();
  }

  Future<Map<String, String>> _nextSong() async {
    Map<String, String> res = {};

    try {
      _songIndex = (_songIndex % _maxSongNumber) + 1;

      AudioEntity? audioEntity =
          await TableAudio.selectById(_songIndex.toString());
      if (audioEntity != null) {
        res = audioEntity.toStringMap();
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return res;
  }
}