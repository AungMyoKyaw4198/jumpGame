import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:jump_game/game/player/character.dart';
import 'package:jump_game/utils/game_constants.dart';


// UFO Class
class Ufo extends SpriteComponent with HasGameRef , HasHitboxes, Collidable{
  final String name;
  final double speed;
  Ufo({required this.name,required this.speed});

  bool isLeft = false;


  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(name);
    size = ufoSize;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    if(isLeft){
      x -= speed* dt;
    } else if(!isLeft) {
      x += speed* dt;
    }

    if(x <= 0 ){
      x = 0;
      isLeft = true;
    }else if(x >= gameRef.canvasSize.x ){
      x = gameRef.canvasSize.x;
      isLeft = false;
    }


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


// Alien Line 
class UfoLine extends SpriteComponent with HasGameRef{
  final String name;
  final double speed;
  UfoLine({required this.name,required this.speed});

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(name);
    size = Vector2(gameRef.canvasSize.x, ufoLineHeight.toDouble() );
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
}


// UFO Manager
class UfoManager extends Component with HasGameRef{

  final List<Vector2> _positionData = [];

  final Random _random = Random();
  final Timer _timer = Timer(5, repeat: true);

  double speed = -mainSpeed.toDouble();

  UfoManager() {
    _timer.onTick = spwanUfos;
  }

  void spwanUfos(){
    
    final randomIndex = _random.nextInt(_positionData.length);
    
    UfoLine line = UfoLine(name: 'gameasset/ufoline.png', speed: speed);
    line.position = Vector2(0, ufoLinePos.toDouble());
    add(line);

    Ufo ufo = Ufo(name: 'gameasset/ufo.png', speed: speed);
    ufo.position = _positionData.elementAt(randomIndex);
    if(ufo.position == _positionData.elementAt(0)){
      ufo.isLeft = true;
    }
    if(ufo.position == _positionData.elementAt(1)){
      ufo.isLeft = false;
    }
    add(ufo);
    
  }

  // As soon as this component is mounted, initilize all the data.
  @override
  void onMount() {
    if(_positionData.isEmpty){
      _positionData.addAll([
        Vector2(0, 0),
        Vector2(gameRef.canvasSize.x, 0),
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