
import 'package:get/get.dart';
import 'package:urge/common/network/base_controller.dart';
import 'package:urge/features/playlist/model/episodes_model.dart';
import 'package:urge/features/playlist/model/playlist_model.dart';
import 'package:urge/features/playlist/services/playlist_service.dart';

class PlaylistController extends GetxController with BaseController {
  final PlaylistService _playlistService = PlaylistService();

  var isLoading = false.obs;
  var isListLoading = false.obs;
  var errorMessage = ''.obs;
  var allPlaylist = <PlaylistModel>[].obs;
  var allNewPlaylist = <PlaylistModel>[].obs;
  var episodes = <EpisodeModel>[].obs;

  void getAllPlaylist() {
    isListLoading(true);
    _playlistService.getAllPlaylist().then((value) {
      try {
        if(value['message'] == "Ok") {
          var playlist =
              List<PlaylistModel>.from((value['data']).map((x) => PlaylistModel.fromMap(x)));
          allPlaylist.value = playlist;
          print(allPlaylist.length);
          isListLoading(false);
        }
      } catch (error) {
        print(error);
      }
    }).catchError((error) {
      isListLoading(false);
      handleError(error);
    });
  }

  void getAllEpisodes(EpisodeModel model){
    isListLoading(true);
    _playlistService.getAllPlaylistEpisodes(model.id).then((value) {
      try {
        if(value['message'] == "Ok") {
          var allEpisodes =
              List<EpisodeModel>.from((value['data']).map((x) => EpisodeModel.fromMap(x)));
          episodes.value = allEpisodes;
          print(episodes.length);
          isListLoading(false);
        }
      }
      catch (error) {
        print(error);
      }
    }).catchError((error) {
      isListLoading(false);
      handleError(error);
    });
  }
}