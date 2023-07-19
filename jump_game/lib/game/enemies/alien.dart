import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:jump_game/game/enemies/bomb.dart';
import 'package:jump_game/game/player/character.dart';
import 'package:jump_game/utils/game_constants.dart';


// Alien Class
class Alien extends SpriteComponent with HasGameRef , HasHitboxes, Collidable{
  final String name;
  final double speed;
  Alien({required this.name,required this.speed});


  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(name);
    size = alienSize;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    y -= speed* dt;

    if(y >= gameRef.canvasSize.y){
      removeFromParent();
    }
  }

  @override
  void onMount() {
    addHitbox(HitboxRectangle());
    super.onMount();
  }

  @override
  void onRemove() {
    removeHitbox(HitboxRectangle());
    super.onRemove();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {

    if(other is Character){
      // playerData.stars++;
      // playerDataProvider.currentScore++;
      // removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

}



// Alien Manager
class AlienManager extends Component with HasGameRef{

  final List<Vector2> _positionData = [];

  final Random _random = Random();
  final Timer _timer = Timer(7, repeat: true);

  double speed = -mainSpeed.toDouble();

  double bombSpeedX = -mainSpeed.toDouble();
  double bombSpeedY = -wallspeed.toDouble();

  AlienManager() {
    _timer.onTick = spwanAliens;
  }

  void spwanAliens(){
    final bombLength = _random.nextInt(2);
    final randomIndex = _random.nextInt(_positionData.length);
  
    Alien alien = Alien(name: 'gameasset/alien.png', speed: speed);
    alien.position = _positionData.elementAt(randomIndex);
    add(alien);

    for(int i =0; i<= bombLength ; i++){
      if(i == 0){
        Bomb bomb =  Bomb(name: 'gameasset/bomb.png', speedx: bombSpeedX, speedy: bombSpeedY);
        bomb.position = _positionData.elementAt(randomIndex);
        if(bomb.position == _positionData.elementAt(0)){
          bomb.isleft = true;
        }
        if(bomb.position == _positionData.elementAt(1)){
          bomb.isleft = false;
        }
        add(bomb);
      } else {
        Bomb bomb2 =  Bomb(name: 'gameasset/bomb.png', speedx: bombSpeedY, speedy: bombSpeedX);
        bomb2.position = _positionData.elementAt(randomIndex);
        if(bomb2.position == _positionData.elementAt(0)){
          bomb2.isleft = true;
        }
        if(bomb2.position == _positionData.elementAt(1)){
          bomb2.isleft = false;
        }
        add(bomb2);
      }
    }
    
  }

  // As soon as this component is mounted, initilize all the data.
  @override
  void onMount() {
    if(_positionData.isEmpty){
      _positionData.addAll([
        Vector2(leftX.toDouble(), 0),
        Vector2(gameRef.canvasSize.x - rightX.toDouble()+ leftX, 0),
      ]);
    }
    _timer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

}