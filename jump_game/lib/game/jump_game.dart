import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';
import 'package:jump_game/game/enemies/alien.dart';
import 'package:jump_game/game/enemies/comet.dart';
import 'package:jump_game/game/enemies/ufo.dart';
import 'package:jump_game/game/player/character.dart';
import 'package:jump_game/game/background/cloud.dart';
import 'package:jump_game/game/powerups/star.dart';
import 'package:jump_game/game/background/world.dart';
import 'package:jump_game/utils/game_constants.dart';
import 'package:jump_game/widgets/game_over.dart';
import 'package:jump_game/widgets/scoreboard.dart';

class JumpGame extends FlameGame with TapDetector, HasCollidables{

  late Character _character;
  late World _world;
  late CloudManager _cloudManager;
  late StarManager _starManager;
  late UfoManager _ufoManager;
  late AlienManager _alienManager;
  late CometManager _cometManager;

  late ParallaxComponent leftWall;
  late ParallaxComponent rightWall;

  static const _imageAssets = [
    'bg/GamePlay.png',
    'bg/cloud.png',
    'bg/wall.png',
    'bg/cloud.png',
    'characters/CharacterFox.png',
    'gameasset/star.png',

  ];

  bool isLeft = true;


  late Timer _timer;
  int scoreTime = 0;

  int index = 0;

  @override
  Future<void>? onLoad() async {
    debugMode = false;
    await images.loadAll(_imageAssets);

    _world = World(name: 'bg/GamePlay.png');
    await add(_world);

    _cloudManager = CloudManager();
    add(_cloudManager);

    leftWall = await loadParallaxComponent(
      [
        ParallaxImageData('bg/wall.png'),
      ],
      fill: LayerFill.width,
      repeat: ImageRepeat.repeatY,
      baseVelocity: Vector2(0, -wallspeed.toDouble()),
      position: Vector2(0, 0),
      anchor: const Anchor(0, 0),
      size: Vector2(wallSize.toDouble(), canvasSize.y) 
    );
    add(leftWall);

    rightWall = await loadParallaxComponent(
      [
        ParallaxImageData('bg/wall.png'),
      ],
      fill: LayerFill.width,
      repeat: ImageRepeat.repeatY,
      baseVelocity: Vector2(0, -wallspeed.toDouble()),
      position: Vector2(canvasSize.x - wallSize.toDouble(), 0),
      size: Vector2(wallSize.toDouble(), canvasSize.y) 
    );
    add(rightWall);

    overlays.add(ScoreBoard.id);

    _starManager =  StarManager();
    add(_starManager);

    _alienManager = AlienManager();
    add(_alienManager);

    _ufoManager = UfoManager();
    add(_ufoManager);

    _cometManager = CometManager();
    add(_cometManager);
    

    _character = Character(name: 'characters/CharacterFox.png');
    add(_character);
    _character.position = Vector2(leftX.toDouble() , canvasSize.y- characterYPos );

    _timer = Timer(double.infinity);

    camera.followComponent(_character,
        worldBounds: Rect.fromLTRB(0, 0, canvasSize.x, canvasSize.y)
    );


    return super.onLoad();
  }

  @override
  void onMount() {
    _timer.start();
    super.onMount();
  }


  @override
  void update(double dt) {
    _timer.update(dt);
    speedUp();

    if(_character.position.x <= leftX && isLeft){
      _character.stopMoving();
    } else if(_character.position.x >= canvasSize.x - rightX && !isLeft){
      _character.stopMoving();
    }

    super.update(dt);

    if(_character.isDead){
      gameOver();
      Future.delayed(const Duration(seconds: 2), () {
        pauseEngine();
        overlays.add(GameOver.id);
      });
      
    }
  }

  void speedUp(){
    if(_timer.current.floor() !=0 ){
      
      if((_timer.current % 30).floor() == 0 ){

        index += 1;

        if(index == 1){
          // start : 30
          _character.speed += 0.1;

          // start : -300;
          _cloudManager.speed += -10;

          _starManager.speed += -10;
          _alienManager.speed += -10;
          _alienManager.bombSpeedX += -10;
          _alienManager.bombSpeedY += -10;
          _ufoManager.speed += -10;
          
          // X : -300, Y: -500;
          _cometManager.speedx += -10;
          _cometManager.speedy += -10;
        }
        

    } else{
      index = 0;
    }
      
      
    }

  }

  void gameOver(){
    scoreTime = _timer.current.floor();
  }

  void playAgain(){
    scoreTime = 0;
    playerDataProvider.currentScore = playerData.stars;
    _timer.stop();
  }


  @override
  void onTap() {
    if(_character.x <= leftX ){
      isLeft = false;
      var delta =  Vector2(canvasSize.x - leftX, canvasSize.y-100) - Vector2(canvasSize.x - rightX, canvasSize.y-100);
      _character.changeSide(Vector2(delta.x , delta.y ));
      

    }else{
      isLeft = true;
      var delta = Vector2(canvasSize.x - rightX, canvasSize.y-100) - Vector2(canvasSize.x - leftX, canvasSize.y-100);
      _character.changeSide(Vector2(delta.x , delta.y));
      
    }

    super.onTap();
  }

}