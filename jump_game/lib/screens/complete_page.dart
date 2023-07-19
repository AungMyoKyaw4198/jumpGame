import 'package:flutter/material.dart';
import 'package:jump_game/utils/game_constants.dart';

class CompletePage extends StatefulWidget {
  const CompletePage({Key? key}) : super(key: key);

  @override
  _CompletePageState createState() => _CompletePageState();
}

class _CompletePageState extends State<CompletePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black,

        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: 50,
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
                        // color: const Color(0xFF53789E),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white,width: 1)
                      ),
                      child: const Text('CASH STORE', style: TextStyle(color: Colors.white),),
                    ),
                  ),

                ],
              ),
            ),

            const Divider(
              height: 1,
              color: Colors.white,
            ),

            Expanded(
              child: ListView.builder(
                itemCount: 20,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context,index){
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ListTile(
                          tileColor: Colors.white,
                          leading: const Icon(Icons.ac_unit , color: Colors.white,),
                          title: const Text('P14 -N' , style: TextStyle(color: Colors.white, fontSize: 25),),
                          subtitle: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text("There is a time in every man's education when he arrives at ...", style: TextStyle(color: Colors.white),),
                          ),
                          trailing: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  // side: BorderSide(color: Colors.red)
                                )
                              )
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                              child: Text("New", style: TextStyle(color: Colors.black),),
                            ),
                            onPressed: (){
                              // print('okay');
                            },
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        color: Colors.white,
                      ),
                    ],
                  );
                }),
            ),

          ],
        ),
      )
    );
  }
}