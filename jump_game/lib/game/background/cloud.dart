import 'dart:math';

import 'package:flame/components.dart';
import 'package:jump_game/utils/game_constants.dart';

class Cloud extends SpriteComponent with HasGameRef {
  final String name;
  final double speed;
  Cloud({required this.name,required this.speed});

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(name);
    size = cloudSize;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    y -= speed* dt;

    if(y >= gameRef.size.y){
      removeFromParent();
    }
  }
}

class CloudManager extends Component with HasGameRef{

  final Random _random = Random();
  final Timer _timer = Timer(1, repeat: true);

  double speed = -mainSpeed.toDouble();

  CloudManager() {
    _timer.onTick = spwanCloud;
  }

  // Generate Random Number in Range
  int randomNumberInRange(int min, int max){
    return min + _random.nextInt(max - min);
  }

  void spwanCloud(){

    Cloud cloud = Cloud(name: 'bg/cloud.png', speed: speed);
    int cloudX =  randomNumberInRange(0,gameRef.size.x.toInt());
    cloud.position = Vector2(cloudX.toDouble(), 0);
    add(cloud);

  }

  // As soon as this component is mounted, initilize all the data.
  @override
  void onMount() {
    _timer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

}