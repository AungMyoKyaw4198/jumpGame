import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jump_game/game/jump_game.dart';
import 'package:jump_game/screens/menu_page.dart';

class PauseMenu extends StatelessWidget {
  static const id = 'pausemenu';

  final JumpGame gameRef;
  const PauseMenu(this.gameRef, {Key? key}) : super(key: key);

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
                            'OPTIONS',
                            style: TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          ),
              const SizedBox(height: 50,),

              Card(
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: const Color(0xFF194B7D),

                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                    child: Wrap(
                      direction: Axis.vertical,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      children: [

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(150, 50),
                            primary: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                          onPressed: () {
                            gameRef.overlays.remove(PauseMenu.id);
                            gameRef.resumeEngine();
                          },
                          child: const Text(
                            'Resume',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF194B7D),
                            ),
                          ),
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(150, 50),
                            primary: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                          onPressed: () {
                            gameRef.overlays.remove(PauseMenu.id);
                            gameRef.pauseEngine();
                            gameRef.playAgain();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const MenuPage()),
                              );
                          },
                          child: const Text(
                            'Exit',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF194B7D),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


              ),

            ],
          ),
        )
    );
  }
}