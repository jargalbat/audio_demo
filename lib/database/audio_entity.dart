import 'package:audio_demo/database/table_audio.dart';
import 'package:audio_service/audio_service.dart';

class AudioEntity {
  String? id;
  String? title;
  String? album;
  String? url;

  AudioEntity({
    this.id,
    this.title,
    this.album,
    this.url,
  });

  AudioEntity.fromMap(Map<String, dynamic> map) {
    id = map[TableAudio.colId];
    title = map[TableAudio.colTitle];
    album = map[TableAudio.colAlbum];
    url = map[TableAudio.colUrl];
  }

  Map<String, dynamic> toMap() => {
        TableAudio.colId: id,
        TableAudio.colTitle: title,
        TableAudio.colAlbum: album,
        TableAudio.colUrl: url,
      };

  Map<String, String> toStringMap() => {
        'id': id ?? '',
        'title': title ?? '',
        'album': album ?? '',
        'url': url ?? '',
      };
}
