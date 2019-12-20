import 'package:flutter/material.dart';
import 'package:movieworldcup/menuview.dart';
import 'moviefight.dart';
import 'webview.dart';


class MainGateView extends StatefulWidget {
  @override
  _MainGateViewState createState() => _MainGateViewState();
}

class _MainGateViewState extends State<MainGateView> with SingleTickerProviderStateMixin {

  AnimationController anicontroller ;

  @override
  void initState(){
    super.initState();
    anicontroller = AnimationController( vsync:this, duration: Duration(milliseconds: 2500));
    anicontroller.forward();
    //anicontroller.reverse();

  }


  //화면이 사라질때??? ok
  @override
  void dispose() {
    // TODO: implement dispose
    anicontroller.dispose();
    super.dispose();

    print('dispose');

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: (
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[SizedBox(height: 100,),
              Center(
                  child: Text('인생영화',
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = Colors.pink[300],))
              ),
                SizedBox(height: 20,),
                Center(
                    child: Text('월드컵',
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1
                            ..color = Colors.blue[300],))
                ),
                //SizedBox(height: 50,),

                Container(

                  width: 200,
                  height: 200,
                  color: Colors.black,
                  child: Material(
                    color: Colors.black,
                    child: Center(
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.red,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          iconSize: 50,
                          icon: AnimatedIcon(

                              progress: anicontroller,
                              icon:AnimatedIcons.pause_play),

                          color: Colors.white,
                          onPressed: ()=> Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return Menuview();

                              })),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  color: Colors.black,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    AnimatedIcon(
                      icon: AnimatedIcons.home_menu,
                      progress: anicontroller,
                    ),
                    Text(' Big Johnson Garcia',)
                  ],)
                ),

                Container(
                    padding: EdgeInsets.all(20.0),
                    width: 250,
                    child: Image.asset('assets/data/naver.png',scale: 0.2,))
                
            ],
        )),
      ),
    );
  }
}


