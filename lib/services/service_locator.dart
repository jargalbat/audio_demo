import '../page_manager.dart';
import 'package:get_it/get_it.dart';

import 'playlist_repository.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // services
  getIt.registerLazySingleton<PlaylistRepository>(() => DemoPlaylist());

  // page state
  getIt.registerLazySingleton<PageManager>(() => PageManager());
}
