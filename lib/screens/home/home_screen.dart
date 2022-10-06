import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../stores/home_store.dart';
import '../../stores/login_store.dart';
import '../../stores/user_manager_store.dart';
import '../login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserManager userController = GetIt.I.get<UserManager>();
  final HomeStore homeController = HomeStore();

  late ReactionDisposer reactionDisposer;

  @override
  void initState() {
    homeController.getVideo();
    reactionDisposer = reaction(
      (_) => GetIt.I.get<UserManager>().user == null, 
      (_) => WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginScreen())
          );
        }
      )
    );
    super.initState();
  }

  @override
  void dispose() {
    reactionDisposer.reaction.dispose();
    homeController.videoPlayerController?.dispose();
    homeController.flickManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Olá ${userController.user?.userName ?? ''}'),
        elevation: 0,
        centerTitle: true,
        actions: <Widget> [
          IconButton(
            onPressed: () {
              GetIt.I.get<LoginStore>().logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen())
              );
            }, 
            icon: const Icon(Icons.logout_outlined)
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (homeController.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }

          if (homeController.error != null) {
            return Center(
              child: Text(
                homeController.error,
              ),
            );
          }

          return Center(
            child: AspectRatio(
              aspectRatio: 1.77,
              child: FlickVideoPlayer(
                flickManager: homeController.flickManager!,
              ),
            ),
          );
        },
      ),
    );
  }
}