import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:jump_game/game/enemies/alien.dart';
import 'package:jump_game/game/enemies/bomb.dart';
import 'package:jump_game/game/enemies/comet.dart';
import 'package:jump_game/game/enemies/ufo.dart';
import 'package:jump_game/utils/game_constants.dart';
import 'package:flame_audio/flame_audio.dart';


class Character extends SpriteComponent with HasGameRef , HasHitboxes, Collidable{
  final String name;

  Character({required this.name})
      : super(
          size: Vector2(characterSizeX.toDouble(),characterSizeY.toDouble())
        ){
      addHitbox(HitboxRectangle());
    }
  
  static const double gravity = 800;
  double speed = characterSpeed.toDouble();
  bool isDead = false;

  Vector2 moveDirection = Vector2.zero();


  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(name);
    return super.onLoad();
  }

  @override
  void onMount() {
    addHitbox(HitboxRectangle());
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);
    

    if(isDead){
      y += mainSpeed* dt;
    }else{
      x += moveDirection.x * speed * dt;  

      if(x < wallSize/2){
        x = leftX.toDouble();
      }else if( x> gameRef.canvasSize.x - wallSize/2){
        x = gameRef.canvasSize.x - rightX.toDouble()+ leftX;      
      }
    }
  }


  void changeSide(Vector2 newMoveDirection){
    moveDirection = newMoveDirection;
  }

  void stopMoving(){
    moveDirection = Vector2.zero();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);

    if(other is Alien || other is Bomb || other is Comet || other is Ufo){
      FlameAudio.play('deadsound.mp3');
      isDead = true;
      gameRef.camera.shake(intensity: 2);

    }
  }
}