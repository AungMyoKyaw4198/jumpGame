import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:jump_game/screens/build_page.dart';
import 'package:jump_game/screens/complete_page.dart';
import 'package:jump_game/screens/play_page.dart';

class MenuPage extends StatefulWidget {
 const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with WidgetsBindingObserver {
  late AppLifecycleState _notification; 
  int _selectedIndex = 0;
  final AssetsAudioPlayer _audioplayer = AssetsAudioPlayer();

  final List<Widget> _pages = [ 
    const PlayPage(), 
    const BuildPage(),
    const CompletePage()
    ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
    });
    switch(_notification){
     case AppLifecycleState.resumed:
       _audioplayer.play();
       break;
     case AppLifecycleState.inactive:
       _audioplayer.pause();
       break;
     case AppLifecycleState.paused:
       _audioplayer.pause();
       break;
     case AppLifecycleState.detached:
       _audioplayer.pause();
       break;
   }
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    _audioplayer.open(
      Audio("assets/audio/bgsound.mp3"),
      autoStart: true,
      loopMode: LoopMode.single,
      playInBackground: PlayInBackground.disabledPause,
      volume: 1.0
    );
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _audioplayer.stop();
    _audioplayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _pages.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, 
        onTap: _onItemTapped,   
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Image.asset('assets/images/bg/play.png'),
            icon: Image.asset('assets/images/bg/play.png',color: Colors.grey,),
            label: 'Play',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset('assets/images/bg/build.png'),
            icon: Image.asset('assets/images/bg/build.png',color: Colors.grey,),
            label: 'Build',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset('assets/images/bg/complete.png'),
            icon: Image.asset('assets/images/bg/complete.png',color: Colors.grey,),
            label: 'Complete',
          ),
        ],
      ),
    );
  }
}