import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jump_game/game/jump_game.dart';
import 'package:jump_game/screens/main_game_page.dart';
import 'package:jump_game/screens/menu_page.dart';
import 'package:jump_game/utils/game_constants.dart';

class GameOver extends StatefulWidget {
  static const id = 'gameover';

  final JumpGame gameRef;
  const GameOver(this.gameRef, {Key? key}) : super(key: key);

  @override
  State<GameOver> createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  bool newRecord = false;

  @override
  void initState() {
    checkNewRecord();
    super.initState();
  }

  checkNewRecord(){
    if(widget.gameRef.scoreTime > playerData.seconds){
      setState(() {
        newRecord = true;
        playerData.seconds = widget.gameRef.scoreTime;
      });
    } else{
      setState(() {
        newRecord = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const Text(
                            'GAME OVER',
                            style: TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          ),

              const SizedBox(height: 50,),

              Card(
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                color: const Color(0xFF194B7D),

                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    children: [
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Column(
                            children: [
                              Image.asset('assets/images/characters/CharacterFox.png'),
                              newRecord? 
                              Container(
                                height: 30,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.center,
                                child: const Text('New Record',style: TextStyle(color: Colors.white),),
                              )
                              : const SizedBox.shrink(),
                            ],
                          ),

                          const SizedBox(width: 30,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('You survived',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                                ),),
                              const SizedBox(height: 10,),
                              Text(widget.gameRef.scoreTime.toString()+' seconds',
                              style: const TextStyle(color: Colors.white,
                                fontSize: 30,
                              ),)
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: 20,),

                      Row(
                        children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                          onPressed: () {
                            widget.gameRef.overlays.remove(GameOver.id);
                            widget.gameRef.pauseEngine();
                            widget.gameRef.playAgain();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const MenuPage()),
                              );
                          },
                          child: const Text(
                            'Main Menu',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF194B7D),
                            ),
                          ),
                        ),

                        const SizedBox(width: 30,),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                          onPressed: () {
                            widget.gameRef.overlays.remove(GameOver.id);
                            widget.gameRef.pauseEngine();
                            widget.gameRef.playAgain();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const MainGamePage()),
                              );
                          },
                          child: const Text(
                            'Play Again',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF194B7D),
                            ),
                          ),
                        ),
                      ],
                      ),
                      

                    ],
                  ),
                ),


              ),
            ],
          ),
        ),
    );
  }
}