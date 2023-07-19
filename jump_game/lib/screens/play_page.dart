// ignore_for_file: sized_box_for_whitespace

import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:jump_game/screens/main_game_page.dart';
import 'package:jump_game/utils/game_constants.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({Key? key}) : super(key: key);

  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  

  @override
  void initState() {
    checkComponentRatio();
    super.initState();
  }


  // Calculate sizes according to screen size
  checkComponentRatio(){
    var pixelRatio = window.devicePixelRatio;
    var logicalScreenSize = window.physicalSize / pixelRatio;
    var logicalWidth = logicalScreenSize.width;

    if(width != logicalWidth){
      leftX = ((leftX/ 411) * logicalWidth).toInt();
      rightX = ((rightX/ 411) * logicalWidth).toInt();

      wallSize = ((wallSize/ 411) * logicalWidth).toInt();
      wallspeed = ((wallspeed/ 411) * logicalWidth).toInt();

      mainSpeed = ((mainSpeed/ 411) * logicalWidth).toInt();

      characterSizeX = ((characterSizeX/ 411) * logicalWidth).toInt();
      characterSizeY = ((characterSizeY/ 411) * logicalWidth).toInt();
      characterYPos = ((characterYPos/ 411) * logicalWidth).toInt();
      characterSpeed = ((characterSpeed/ 411) * logicalWidth).toInt();

      cloudSize = Vector2( ((cloudSize.x/ 411) * logicalWidth), ((cloudSize.y/ 411) * logicalWidth));

      starSize = ((starSize/ 411) * logicalWidth).toInt();

      alienSize = Vector2( ((alienSize.x/ 411) * logicalWidth), ((alienSize.y/ 411) * logicalWidth));

      bombSize = ((bombSize/ 411) * logicalWidth).toInt();

      cometSize = Vector2( ((cometSize.x/ 411) * logicalWidth), ((cometSize.y/ 411) * logicalWidth));

      ufoSize = Vector2( ((ufoSize.x/ 411) * logicalWidth), ((ufoSize.y/ 411) * logicalWidth));

      ufoLineHeight = ((ufoLineHeight/ 411) * logicalWidth).toInt();
      ufoLinePos = ((ufoLinePos/ 411) * logicalWidth).toInt();

      width = logicalWidth;
    }
    

  }

  calculateLeftX(){
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          child: Stack(

            children: [
              
              Image.asset('assets/images/bg/GameMenu.png',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                repeat: ImageRepeat.repeatY,
              ),

              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(height: 30,),

                    const Text('PHASE ONE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32
                      ),
                      ),
                    
                    const SizedBox(height: 50,),

                    CircleAvatar(
                      child:  Image.asset('assets/images/characters/CharacterFox.png',
                        fit: BoxFit.cover,
                        width: 40,
                        ),
                      backgroundColor: Colors.black,
                      radius: 50,
                    ),

                    const SizedBox(height: 30,),

                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        child: const Text('Change Character', 
                          style: TextStyle(color: Colors.white, fontSize: 15,letterSpacing: 1)
                          ),
                        onPressed: (){

                        },
                      ),
                    ),

                    const SizedBox(height: 50,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 20,
                          width: MediaQuery.of(context).size.width - 230,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            child: const Text('Progress Bar', 
                              style: TextStyle(color: Colors.white, letterSpacing: 2)
                              ),
                            onPressed: (){

                            },
                          ),
                        ),
                        const SizedBox(width: 20,),
                        const Text('70%', style: TextStyle(color: Colors.white),)
                      ],
                    ),

                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Container(
                            width: MediaQuery.of(context).size.width - 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextButton(
                              child: const Text('Start Game', 
                                style: TextStyle(color: Colors.black, fontSize: 25)
                                ),
                              onPressed: (){
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MainGamePage()),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 20,),
                          
                          Container(
                            width: MediaQuery.of(context).size.width - 100,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey,width: 2),
                            ),
                            child: TextButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.lock , color: Colors.grey,),
                                  SizedBox(width: 20,),

                                  FittedBox(
                                    child: Text('Unlock Phase 2', 
                                    style: TextStyle(color: Colors.grey, fontSize: 25)
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: (){

                              },
                            ),
                          ),
                        ],
                      )
                    ),
                    
                  ],
                ),
              ),

              
            ],
          ),
        ),
      ),
    );
  }
}