import 'package:flame/components.dart';

class World extends SpriteComponent with HasGameRef {
  final String name;
  World({required this.name});

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(name);
    size = gameRef.canvasSize;
    return super.onLoad();
  }
}