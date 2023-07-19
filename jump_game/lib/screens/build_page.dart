import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jump_game/utils/game_constants.dart';

class BuildPage extends StatefulWidget {
  const BuildPage({Key? key}) : super(key: key);

  @override
  _BuildPageState createState() => _BuildPageState();
}

class _BuildPageState extends State<BuildPage> {
  int _current = 0;
  List<Widget> itemsList = [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white12,
                          border: Border.all(color: Colors.white,width: 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 50,),
                            const Icon(Icons.book, size: 60,),

                            const Text('5 ARTEFACTS', style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                              ),),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(' = ', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                                Image.asset('assets/images/gameasset/star.png' , width: 30,height: 30,),
                                const Text('20 STARS', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                              ],
                              ),
                            
                            Container(
                              height: 60,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.white,width: 1)
                              ),
                              child: const Text('Build', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                            ),
                          ],
                          ),
                      
                        ),
                      Container(color: Colors.green,height: 500,),
                      Container(color: Colors.black,height: 500,),
                      Container(color: Colors.white,height: 500,),
                      Container(color: Colors.blue,height: 500,),
                    ];

   int itemLength = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
                color: Color(0xFF778899),
              ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.black26,

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

                      Text(playerData.stars.toString(), style: const TextStyle(color: Colors.white),),
                    ],
                  ),

                  GestureDetector(
                    onTap: (){
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
                      child: const Text('CASH STORE', style: TextStyle(color: Colors.white),),
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 50,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
            
                  Expanded(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: double.infinity,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        initialPage: 0,
                        autoPlay: false,
                        onPageChanged: (index , dynamic onPageChnagedReason){
                          setState(() {
                            _current = index;
                          });
                        },
                    
                      ),
                      items: itemsList
                    ),
                  ),
            
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Center(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: itemsList.length,
                        itemBuilder: (context,index){
                          return Center(
                            child: Container(
                              width: 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == index
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                          );
                        }
                      ),
                    ),
                  ),
            
                 
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}