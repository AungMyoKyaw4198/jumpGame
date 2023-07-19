import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:jump_game/game/player/character.dart';
import 'package:jump_game/utils/game_constants.dart';

class Comet extends SpriteComponent with HasGameRef , HasHitboxes, Collidable{
  final String name;
  final double speedx;
  final double speedy;
  Comet({required this.name,required this.speedx, required this.speedy});

  bool isleft = false;


  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(name);
    size = cometSize;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    if(isleft){
      x -= speedx* dt;
      y -= speedy* dt;
    } else if(!isleft) {
      x += speedx* dt;
      y -= speedy* dt;
    }
    
    
    
    if(x <= 0 || x >=  gameRef.canvasSize.x){
      removeFromParent();
    }
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
    }
    super.onCollision(intersectionPoints, other);
  }

}


class CometManager extends Component with HasGameRef{

  final List<Vector2> _positionData = [];

  final Random _random = Random();
  final Timer _timer = Timer(10, repeat: true);

  double speedx = -mainSpeed.toDouble();
  double speedy = -wallspeed.toDouble();

  CometManager() {
    _timer.onTick = spwanComets;
  }

  void spwanComets(){
    // spwan maximun 6 stars at a time
    // final cometLength = _random.nextInt(6);
    
    final randomIndex = _random.nextInt(_positionData.length);

    Comet comet = Comet(name: 'gameasset/comet.png', speedx: speedx, speedy: speedy);
    comet.position = _positionData.elementAt(randomIndex);

    if(comet.position == _positionData.elementAt(0)){
      comet.isleft = true;
      comet.flipHorizontally();
    }
    if(comet.position == _positionData.elementAt(1)){
      comet.isleft = false;
    }

    add(comet);

    

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