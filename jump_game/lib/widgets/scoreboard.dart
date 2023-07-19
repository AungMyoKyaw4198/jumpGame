import 'package:flutter/material.dart';
import 'package:jump_game/game/jump_game.dart';
import 'package:jump_game/provider/playerdata_provider.dart';
import 'package:jump_game/utils/game_constants.dart';
import 'package:jump_game/widgets/pause_menu.dart';
import 'package:provider/provider.dart';


class ScoreBoard extends StatelessWidget {
  static const id = 'scoreboard';

  final JumpGame gameRef;
  const ScoreBoard(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: const Color(0xFF194B7D),
      height: 50,
      width: gameRef.size.x,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Row(
            children: [
              const SizedBox(width: 10,),
              Image.asset('assets/images/gameasset/money.png'),
              const SizedBox(width: 5,),
              Text(playerData.money.toString() , style: const TextStyle(color: Colors.white),),

              const SizedBox(width: 30,),

              Image.asset('assets/images/gameasset/star.png' , width: 30,height: 30,),

              ChangeNotifierProvider.value(
                value: playerDataProvider,
                child: Selector<PlayerDataProvider, int>(
                  selector: (_, playerData) => playerData.currentScore,
                  builder: (_, stars, __) {
                    return Text(
                      '$stars',
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
            ],
          ),


          GestureDetector(
            onTap: (){
              gameRef.overlays.add(PauseMenu.id);
              gameRef.pauseEngine();
            },
            child: Container(
              height: 30,
              width: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF53789E),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.white,width: 1)
              ),
              child: const Text('OPTIONS', style: TextStyle(color: Colors.white),),
            ),
          ),

        ],
      ),
    );
  }
}