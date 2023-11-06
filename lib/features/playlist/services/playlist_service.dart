

import 'package:get_storage/get_storage.dart';
import 'package:urge/common/network/base_controller.dart';

import '../../../common/network/base_client.dart';

class PlaylistService with BaseController {
  final introdata = GetStorage();
  BaseClient baseClient = BaseClient();

  Future<dynamic> getAllPlaylist() async {
    return await baseClient.get(
      url,
      '/playlists',
    );
  }

  Future<dynamic> getAllPlaylistEpisodes(int? id) async {
    return await baseClient.get(
      url,
      '/episodes?playlist=$id',
    );
  }


}