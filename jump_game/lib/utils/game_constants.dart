import 'package:flame/components.dart';
import 'package:jump_game/ob/player_data.dart';
import 'package:jump_game/provider/playerdata_provider.dart';

PlayerData playerData = PlayerData(seconds: 0,stars: 0,money: 0);

// Need to show collected Stars
PlayerDataProvider playerDataProvider = PlayerDataProvider();

// Component Size
double width = 0;

// Left and Right X
int leftX = 15;
int rightX = 70;

// wall Size 
int wallSize = 80;
int wallspeed = 500;

// character size
int characterSizeX = 39;
int characterSizeY = 49;
int characterYPos = 120;
int characterSpeed = 30;

int mainSpeed = 300;

// 36 x 36
int starSize = 36;


Vector2 cloudSize = Vector2(74, 47);


Vector2 alienSize = Vector2(44,55);

// 40 x 40
int bombSize = 40;

Vector2 cometSize = Vector2(85,79);

Vector2 ufoSize = Vector2(55,33);

// 414 x 2
int ufoLineHeight = 2;
int ufoLinePos = 15;

