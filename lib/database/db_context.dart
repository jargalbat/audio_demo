import 'package:audio_demo/database/audio_entity.dart';
import 'package:audio_demo/database/table_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:path/path.dart';

class DbContext {
  static final DbContext _singleton = DbContext._internal();

  factory DbContext() {
    return _singleton;
  }

  DbContext._internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await _initDb();
    return _db!;
  }

  // Init (or create) database
  Future<Database?> _initDb() async {
    Database? db;

    try {
      final documentDirectory = await getApplicationDocumentsDirectory();
      //home://directory/files/audio.db
      final path = join(documentDirectory.path, 'audio.db');

      db = await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
        password: 'DB_PASSWORD',
      );
    } catch (e) {
      debugPrint(e.toString());
    }

    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    try {
      // Create table
      await db.execute('''
        CREATE TABLE ${TableAudio.tblName}(
          ${TableAudio.colId} TEXT PRIMARY KEY NOT NULL,
          ${TableAudio.colTitle} TEXT NOT NULL,
          ${TableAudio.colAlbum} TEXT NOT NULL,
          ${TableAudio.colUrl} TEXT NOT NULL
        )
      ''');

      // Seed data
      await _seedTblAudio(db);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _seedTblAudio(Database db) async {
    try {
      for (int i = 1; i <= 16; i++) {
        var audioEntity = AudioEntity(
          id: i.toString(),
          title: 'Song $i',
          album: 'SoundHelix',
          url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-$i.mp3',
        );

        await db.insert(TableAudio.tblName, audioEntity.toMap());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
