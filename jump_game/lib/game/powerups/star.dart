import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:jump_game/game/player/character.dart';
import 'package:jump_game/utils/game_constants.dart';
import 'package:flame_audio/flame_audio.dart';


class Star extends SpriteComponent with HasGameRef , HasHitboxes, Collidable{
  final String name;
  final double speed;
  Star({required this.name,required this.speed}):super(
    size: Vector2.all(starSize.toDouble()),
  );


  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(name);
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
      FlameAudio.play('starsound.mp3');
      playerDataProvider.currentScore++;
      playerData.stars++;
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

}


class StarManager extends Component with HasGameRef{

  final List<Vector2> _positionData = [];

  final Random _random = Random();
  final Timer _timer = Timer(3, repeat: true);

  double speed = -mainSpeed.toDouble();

  StarManager() {
    _timer.onTick = spwanStars;
  }

  void spwanStars(){
    // spwan maximun 6 stars at a time
    final starLength = _random.nextInt(6);
    
    for(int i =0; i<= starLength ; i++){
      final randomIndex = _random.nextInt(_positionData.length);

      Star star = Star(name: 'gameasset/star.png', speed: speed);
      star.position = _positionData.elementAt(randomIndex);

      if(i == 0){
        star.y = 0;
      }else{
        star.y -= starSize * i;
      }

      add(star);
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