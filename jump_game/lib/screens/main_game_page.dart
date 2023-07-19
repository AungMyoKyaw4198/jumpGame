import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:jump_game/game/jump_game.dart';
import 'package:jump_game/widgets/game_over.dart';
import 'package:jump_game/widgets/pause_menu.dart';
import 'package:jump_game/widgets/scoreboard.dart';

class MainGamePage extends StatefulWidget {
  const MainGamePage({Key? key}) : super(key: key);

  @override
  _MainGamePageState createState() => _MainGamePageState();
}

class _MainGamePageState extends State<MainGamePage> with WidgetsBindingObserver {
  late AppLifecycleState _notification; 
  final JumpGame _game = JumpGame();
  final AssetsAudioPlayer _audioplayer = AssetsAudioPlayer();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
    });
    switch(_notification){
     case AppLifecycleState.resumed:
       _game.overlays.add(PauseMenu.id);
       _game.pauseEngine();
       _audioplayer.play();
       break;
     case AppLifecycleState.inactive:
       _game.overlays.add(PauseMenu.id);
       _game.pauseEngine();
       _audioplayer.pause();
       break;
     case AppLifecycleState.paused:
       _audioplayer.pause();
       break;
     case AppLifecycleState.detached:
       _audioplayer.pause();
       break;
   }
  }
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    _audioplayer.open(
      Audio("assets/audio/bgsound.mp3"),
      autoStart: true,
      loopMode: LoopMode.single,
      playInBackground: PlayInBackground.disabledPause,
      volume: 1.0
    );
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _audioplayer.stop();
    _audioplayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
        body: GameWidget(

          loadingBuilder: (conetxt) => const Center(
            child: SizedBox(
              width: 200,
              child: LinearProgressIndicator(),
            ),
          ),

          overlayBuilderMap: {
            ScoreBoard.id: (_, JumpGame gameRef) => ScoreBoard(gameRef),
            PauseMenu.id: (_, JumpGame gameRef) => PauseMenu(gameRef),
            GameOver.id: (_, JumpGame gameRef) => GameOver(gameRef),
          },
          
          game: _game,
        ),
      );
  }

}