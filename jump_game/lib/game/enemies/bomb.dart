import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:jump_game/utils/game_constants.dart';

class Bomb extends SpriteComponent with HasGameRef , HasHitboxes, Collidable{
  final String name;
  final double speedx;
  final double speedy;
  Bomb({required this.name,required this.speedx, required this.speedy});

  bool isleft = false;

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(name);
    size = Vector2.all(bombSize.toDouble());
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

}
