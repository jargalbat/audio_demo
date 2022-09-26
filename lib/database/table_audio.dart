import 'package:audio_demo/database/audio_entity.dart';
import 'package:audio_demo/database/db_context.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class TableAudio {
  static const tblName = 'audio';

  static const colId = 'id';
  static const colTitle = 'title';
  static const colAlbum = 'album';
  static const colUrl = 'url';

  static Future<List<AudioEntity>> selectAll({int? limit}) async {
    List<AudioEntity> res = [];
    try {
      Database db = await DbContext().db;
      var query = '''
        SELECT * FROM ${TableAudio.tblName}
      ''';
      if (limit != null) {
        query += ' LIMIT $limit';
      }

      var result = await db.rawQuery(query);
      if (result.isNotEmpty) {
        res = result.map((el) => AudioEntity.fromMap(el)).toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return res;
  }

  static Future<AudioEntity?> selectById(String id) async {
    AudioEntity? res;
    try {
      Database db = await DbContext().db;

      var result = await db.rawQuery('''
        SELECT * FROM ${TableAudio.tblName}
        WHERE ${TableAudio.colId} = $id
        LIMIT 1
      ''');

      if (result.isNotEmpty) {
        res = AudioEntity.fromMap(result.first);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return res;
  }
}
