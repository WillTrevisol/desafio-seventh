import 'package:flick_video_player/flick_video_player.dart';
import 'package:mobx/mobx.dart';
import 'package:video_player/video_player.dart';

import '../repository/video.dart';
part 'home_store.g.dart';

// ignore: library_private_types_in_public_api
class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  
  @observable
  bool loading = false;

  @observable
  dynamic error;

  @observable
  String url = '';

  @observable
  FlickManager? flickManager;

  @observable
  VideoPlayerController? videoPlayerController;

  @action
  void setLoading(bool value) => loading = value;

  @action
  void setError(dynamic value) => error = value;

  @action
  void setUrl(String value) => url = value;

  @action
  Future<void> getVideo() async {
    setLoading(true);
    setError(null);

    try {
      final responseUrl = await VideoRepository().networkVideo();

      if (responseUrl != null) {
        setUrl(responseUrl);

        videoPlayerController = VideoPlayerController.network(responseUrl);

        flickManager = FlickManager(videoPlayerController: videoPlayerController!);
      }

    } catch (e) {
      setError(e);
    }
    setLoading(false);
  }

}