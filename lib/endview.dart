import 'package:flutter/material.dart';
import 'package:movieworldcup/menuview.dart';
import 'package:admob_flutter/admob_flutter.dart';

class MyEndview extends StatefulWidget {
  @override
  _MyEndviewState createState() => _MyEndviewState();
}

class _MyEndviewState extends State<MyEndview> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:

    SafeArea(
      child: SizedBox.expand(
          child:Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  //padding: EdgeInsets.only(top: 32.0),
                  child: AdmobBanner(
                      adUnitId: '',
                      adSize: AdmobBannerSize.FULL_BANNER,
                      listener: (AdmobAdEvent event, Map<String, dynamic> args){
                        //handleEvent(event,args,'Banner');
                      }
                  ),
                  color: Colors.red,
                ),
                //SizedBox(height: 50,),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('인생영화 월드컵', style: TextStyle(fontSize: 40),),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 0, 16),
                  child: Text('영화 대 영화 ', style: TextStyle(fontSize: 40),),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('App Version : 1.1.0', style: TextStyle(fontSize: 20),),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('이 App은 Flutter로 만들었습니다.', style: TextStyle(fontSize: 20),),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('OpenApi : Naver 영화검색 Api.', style: TextStyle(fontSize: 20),),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('만든이 kery027@gmail.com ', style: TextStyle(fontSize: 20),),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('도움준사람들 : 백사장 돼보 .님', style: TextStyle(fontSize: 15),),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 100,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Material(
                        //color: Colors.white,
                        child: Center(
                          child: Ink(
                            decoration: const ShapeDecoration(
                              color: Colors.pink,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back),
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
                  ],
                )

              ],
            ),
          )

      ),
    ),


    );
  }
}
