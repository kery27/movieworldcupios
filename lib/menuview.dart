import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:movieworldcup/moviefight.dart';
import 'package:movieworldcup/webview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Menuview extends StatefulWidget {

  @override
  _MenuviewState createState() => _MenuviewState();
}

class _MenuviewState extends State<Menuview> with SingleTickerProviderStateMixin {

  static List<String> gamelist = [];
  static List<Color> colorlist = [];
  static List<String> resultlist = [];

  List<dynamic> userresult = [];

  AnimationController anicontroller ;

  List urllist = [];
  List linkurllist = [];

  List movielist = [];
  List romancelist =[];

  List actionlist =[];

  List dramalist =[];

  List horrorlist =[];

  List anilist =[];

  List urllist2 =[];


  _SavedData() async {
    // Get shared preference instance
    var future = Future.delayed(Duration(milliseconds: 1000), (){

    });
    await future;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      // Set value
      String result = json.encode(userresult);
      prefs.setString('resultjson', result);
      //print('result ' );
      //print('결과'+prefs.getString('resultjson'));
    });
  }

  _loaddData() async {
    // Get shared preference instance

    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      //prefs.setString('resultjson', '');
      //return;
      // Set value
      String str = prefs.getString('resultjson');
      //print('str $str');
      if (str == '' || str == []){
        str = '[{"test":"1","name":"kimchi"}]';
      }
      List resultjson = json.decode(str);

      userresult = resultjson;
      print('가져오기');
      print(userresult);
      print(userresult[0]['name']);
      print(json.decode(str));
    });

  }

  String _findmovieinfo(key,value,List lst) {



    for (int i = 0; i < lst.length; i++){
      if (value == lst[i][key]){
        return lst[i]['name'];
      }
    }
  }

  String _findmovieurl(String key,value,List lst) {

    for (int i = 0; i < lst.length; i++){
      if (value == lst[i][key]){
        return lst[i]['url'];
      }
    }

  }

  String _findmovielink(String key,value,List lst) {
    print('dttdtdtd111');
    for (int i = 0; i < lst.length; i++){
      if (value == lst[i]['id']){
        print('dttdtdtd');
        return lst[i]['link'];
      }
    }

  }

  _initMovielist() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String str = prefs.getString('resultmovielife');
    //print('print');
    //print('str $str');


    //todo 지금은 영화의 인덱스만 로컬에 저장햄 그러나
    // 영화의 이미지 정보나 링크 정보가 로컬에 저장되어 있을 필요가 있지
    // 이걸 하려면 영화 정보나 링크 정보가 제이슨으로 저장이 되어 이써야지
    // 영화 정보랑 제이슨 정보를 저장 해놓는 로컬 변수를 만들고
    // 거기서 영화 정보를 불러다가

    // 값이 존재 하지 않으면 api를 태워서 값을 가져오고

    // 가져온 값을 저장하는 로직을 넣어야 하는데
    // 대문에서 해야하나 싶네.
    // 영화는 게임이 끝났을때 결정이 되자나.
    // 일단 만들고 어디서 할지를 정하자


    setState(() {
      //Todo 환경설정 값을 가져와서 값이 있는 (플레이 결과가 있는) 리스트에 차례로 넣어주기.
      //print('이닛이 시작되엇냐?');

      if(str != '' && str != null){
        String movie_name = _findmovieinfo('id',str,movielist);
        if (movie_name != ''){
          //값 세팅
          resultlist[0] = movie_name;
          urllist[0]['url'] = _findmovieurl('id',str,movielist);
          urllist[0]['link'] = _findmovielink('link',str,movielist) ;
          if(urllist[0]['link'] == '' || urllist[0]['link'] == null){
            //var rtn = getmovieinfo(urllist[0]);
            //urllist[0]['link'] =

            //print(urllist[0]);
          }
        }
      }

      str = prefs.getString('resultmovieromance');
      if(str != ''&& str != null){
        String movie_name = _findmovieinfo('id',str,romancelist);
        if (movie_name != ''){
          //값 세팅
          resultlist[1] = movie_name;
          //print(_findmovieurl('id',str,romancelist));
          urllist[1]['url'] = _findmovieurl('id',str,romancelist);
          urllist[1]['link'] = _findmovielink('link',str,romancelist) ;
          if(urllist[1]['link'] == '' || urllist[1]['link'] == null){
            //var rtn = getmovieinfo(urllist[1]);
            //urllist[0]['link'] =
            //print(urllist[1]);
          }
        }
      }

      str = prefs.getString('resultmovieaction');
      if(str != ''&& str != null){
        String movie_name = _findmovieinfo('id',str,actionlist);
        if (movie_name != ''){
          //값 세팅
          resultlist[2] = movie_name;
          urllist[2]['url'] = _findmovieurl('id',str,actionlist);
          urllist[2]['link'] = _findmovielink('link',str,actionlist) ;
        }
      }

      str = prefs.getString('resultmoviehorror');
      //print('horror $str');
      if(str != ''&& str != null){
        String movie_name = _findmovieinfo('id',str,horrorlist);
        if (movie_name != ''){
          //값 세팅
          resultlist[3] = movie_name;
        //  print('dddddd '+_findmovieurl('id',str,horrorlist));
          urllist[3]['url'] = _findmovieurl('id',str,horrorlist);
          urllist[3]['link'] = _findmovielink('link',str,horrorlist) ;

        //  print('dddddd '+urllist[3]['url']);
        }
      }

      str = prefs.getString('resultmoviedrama');
      if(str != ''&& str != null){
        String movie_name = _findmovieinfo('id',str,dramalist);
        if (movie_name != ''){
          //값 세팅
          resultlist[4] = movie_name;
          urllist[4]['url'] = _findmovieurl('id',str,dramalist);
          urllist[4]['link'] = _findmovielink('link',str,dramalist) ;
        }
      }

      str = prefs.getString('resultmovieanimation');
      if(str != ''&& str != null){
        String movie_name = _findmovieinfo('id',str,anilist);
        if (movie_name != ''){
          //값 세팅
          resultlist[5] = movie_name;
          urllist[5]['url'] = _findmovieurl('id',str,anilist);
          urllist[5]['link'] = _findmovielink('link',str,anilist) ;
        }
      }
    });
  }


  @override
  void initState(){
    super.initState();
    //getJSONData();

    //_loaddData();
    //_SavedData();


    gamelist = ['인 생 영 화','Romance','Action','Horror','Drama','Animation'];
    colorlist = [Color.fromRGBO(233, 243, 158,1),
                 Color.fromRGBO(244, 209, 250,1),
                 Color.fromRGBO(255, 244, 122,1),
                 Color.fromRGBO(242, 152, 135,1),
                 Colors.green[700],Colors.yellow[700]];
    colorlist = [Colors.red[700],
                Color.fromRGBO(244, 209, 250,1),
                Colors.blue[700],
                Colors.purple[400],
                Colors.green[500],Colors.yellow[700]];
    //resultlist = ['레옹','노트북','포드페라리','그랜드부다페스트호텔','?','?'];

    urllist = [
      {
        "genre": "0",
        "name": "노트북",
        //"url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0388/38899_P47_165103.jpg"
        "url" : "",
        "link" : "",
        "yearfrom" : "2004",
        "yearto" : "2004",
      },
      {
        "genre": "1",
        "name": "레옹",
        //"url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0171/17170_P54_101933.jpg"
        "url" : "",
        "link" : "",
        "yearfrom" : "",
        "yearto" : "",
      },
      {
        "genre": "2",
        "name": "매드맥스",
        //"url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0777/77768_P83_104913.jpg"
        "url" : "",
        "link" : "",
        "yearfrom" : "",
        "yearto" : "",
      },
      {
        "genre": "3",
        "name": "드래그미투헬",
        //"url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0525/E2524-01.jpg"
        "url" : "",
        "link" : "",
        "yearfrom" : "",
        "yearto" : "",
      },
      {
        "genre": "3",
        "name": "그랜드부다페스트호텔",
        //"url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0976/97612_P65_134400.jpg"
        "url" : "",
        "link" : "",
        "yearfrom" : "",
        "yearto" : "",
      },
      {
        "genre": "3",
        "name": "라따뚜이",
        //"url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0650/F5021-00.jpg"
        "url" : "",
        "link" : "",
        "yearfrom" : "",
        "yearto" : "",
      },
    ];

    movielist = [{"id":"0", "name":"러브액츄얼리","url":"https://ssl.pstatic.net/imgmovie/mdi/mit110/0368/36843_P106_102707.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=36843"},
      {"id":"1", "name":"그랜드 부다페스트 호텔","url" :"https://ssl.pstatic.net/imgmovie/mdi/mit110/0976/97612_P65_134400.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=97612"},
      {"id":"2", "name":"라라랜드","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1349/134963_P15_094953.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=134963"},
      {"id":"3", "name":"보헤미안 랩소디","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1564/156464_P49_182103.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=156464"},
      {"id":"4", "name":"다크나이트","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0720/72054_P64_134619.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=72054"},
      {"id":"5", "name":"범죄와의전쟁","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0825/82540_P13_161030.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=82540"},
      {"id":"6", "name":"라이온킹","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0165/16521_P45_105412.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=169637"},
      {"id":"7", "name":"매트릭스","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0244/24452_P76_143941.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=24452"},
      {"id":"8", "name":"아멜리에","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0325/32588_P01_115408.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=32588"},
      {"id":"9", "name":"이터널선샤인","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0384/38444_P53_180242.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=38444"},
      {"id":"10","name":"매드맥스","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0777/77768_P83_104913.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=77768"},
      {"id":"11","name":"타이타닉","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0188/18847_P96_094922.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=18847"},
      {"id":"12","name":"그녀","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1019/101950_P40_140928.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=101950"},
      {"id":"13","name":"겨울왕국","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1009/100931_P98_151621.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=100931"},
      {"id":"14","name":"인터스텔라","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0452/45290_P59_104735.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=45290"},
      {"id":"15","name":"레옹","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0171/17170_P54_101933.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=17170"},
      {"id":"16","name":"조커","url":"https://ssl.pstatic.net/imgmovie/mdi/mit110/1676/167613_P09_182225.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=167613"},
      {"id":"17","name":"어밴져스","url":"https://ssl.pstatic.net/imgmovie/mdi/mit110/1369/136900_P57_104126.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=136315"},
      {"id":"18","name":"트루먼쇼","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0190/19099_P17_145050.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=19099"},
      {"id":"19","name":"노트북","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0388/38899_P47_165103.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=38899"},
      {"id":"20", "name":"터미네이터","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0100/A0028-00.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=10200"},
      {"id":"21", "name":"인생은아름다워","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0221/22126_P16_103912.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=22126"},
      {"id":"22", "name":"대부","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0100/10071_P42_111240.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=10071"},

    ];

    romancelist =
    [{"id":"0", "name":"러브레터","url":"https://ssl.pstatic.net/imgmovie/mdi/mit110/0190/19031_P46_101158.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=19031"},
      {"id":"1", "name":"어바웃 타임","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0920/92075_P31_154949.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=92075"},
      {"id":"2", "name":"라라랜드","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1349/134963_P15_094953.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=134963"},
      {"id":"3", "name":"이터널선샤인","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0384/38444_P53_180242.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=38444"},
      {"id":"4", "name":"노트북","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0388/38899_P47_165103.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=38899"},
      {"id":"5", "name":"지금만나러 갑니다","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0396/39636_P17_152919.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=168298"},
      {"id":"6", "name":"노팅힐","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0248/24830_P18_133358.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=24830"},
      {"id":"7", "name":"말할 수 없는 비밀","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0685/68555_P28_112929.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=68555"},
      {"id":"8", "name":"비긴어게인","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0963/96379_P05_170110.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=96379"},
      {"id":"9", "name":"이프온리","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0394/39440_P18_111613.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=39440"},
      {"id":"10","name":"타이타닉","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0188/18847_P96_094922.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=18847"},
      {"id":"11","name":"그녀","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1019/101950_P40_140928.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=101950"},
      {"id":"12","name":"조제호랑이그리고물고기들","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0384/38464_P19_105505.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=38464"},
    ];

    actionlist =
    [{"id":"0", "name":"어밴져스","url":"https://ssl.pstatic.net/imgmovie/mdi/mit110/1369/136900_P57_104126.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=136315"},
      {"id":"1", "name":"킹스맨","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1142/114249_P62_111022.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=159893"},
      {"id":"2", "name":"터미네이터","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0100/A0028-00.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=10200"},
      {"id":"3", "name":"맨인블랙","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0181/18153_P32_104945.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=18153"},
      {"id":"4", "name":"스타워즈","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1446/144694_P02_114257.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=144694"},
      {"id":"5", "name":"매트릭스","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0244/24452_P76_143941.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=24452"},
      {"id":"6", "name":"포드페라리","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1817/181710_P21_111616.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=181710"},
      {"id":"7", "name":"카지노로얄","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0421/D2117-00.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=42117"},
      {"id":"8", "name":"매드맥스","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0777/77768_P83_104913.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=77768"},
      {"id":"9", "name":"본 얼티메이텀","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0590/59075_P48_111546.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=59075"},
      {"id":"10","name":"킬빌","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0132/A3244-00.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=13244"},
      {"id":"11","name":"테이큰","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0471/47152_P24_142422.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=47152"},
      {"id":"12","name":"존윅","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1233/123300_P45_103738.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=181698"},
      {"id":"13","name":"미션임파서블","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0533/53372_P12_111230.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=154222"},
    ];

    dramalist =
    [{"id":"0", "name":"조커","url":"https://ssl.pstatic.net/imgmovie/mdi/mit110/1676/167613_P09_182225.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=167613"},
      {"id":"1", "name":"쇼생크 탈출","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0174/17421_P16_095733.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=17421"},
      {"id":"2", "name":"기생충","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1619/161967_P80_151640.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=161967"},
      {"id":"3", "name":"타짜","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0577/E7723-01.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=57723"},
      {"id":"4", "name":"내부자들","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1217/121788_P28_120120.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=121788"},
      {"id":"5", "name":"위플래쉬","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1041/104189_P01_184328.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=119632"},
      {"id":"6", "name":"레미제라블","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0897/89755_P73_104924.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=89755"},
      {"id":"7", "name":"베테랑","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1159/115977_P11_102909.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=115977"},
      {"id":"8", "name":"신세계","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0910/91031_P53_103806.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=91031"},
      {"id":"9", "name":"인투더와일드","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0677/F7710-01.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=67710"},
      {"id":"10","name":"트로이","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0377/C7742-00.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=37742"},
      {"id":"11","name":"살인의추억","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0359/C5901-00.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=35901"},
      {"id":"12","name":"미스리틀선샤인","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0605/F0530-00.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=60530"},
      {"id":"13","name":"펄프픽션","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0165/A6571-01.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=16571"},
      {"id":"14","name":"글래디에이터","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0292/29217_P37_113214.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=29217"},

    ];


    horrorlist =
    [{"id":"0", "name":"컨저링","url":"https://ssl.pstatic.net/imgmovie/mdi/mit110/0928/92823_P16_143047.jpg","link":"https://movie.naver.com/movie/bi/mi/basic.nhn?code=92823"},
      {"id":"1", "name":"알포인트","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0372/C7261-00.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=37261"},
      {"id":"2", "name":"곤지암","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1724/172454_P62_140358.jpg","link":"https://movie.naver.com/movie/bi/mi/basic.nhn?code=172454"},
      {"id":"3", "name":"쏘우","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0577/E7723-01.jpg","link":"https://movie.naver.com/movie/bi/mi/basic.nhn?code=39614"},
      {"id":"4", "name":"28일후","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0363/C6342-00.jpg","link":"https://movie.naver.com/movie/bi/mi/basic.nhn?code=36342"},
      {"id":"5", "name":"겟아웃","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1560/156083_P09_134520.jpg","link":"https://movie.naver.com/movie/bi/mi/basic.nhn?code=156083"},
      {"id":"6", "name":"장화홍련","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0367/C6732-00.jpg","link":"https://movie.naver.com/movie/bi/mi/basic.nhn?code=36732"},
      {"id":"7", "name":"곡성","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1210/121051_P54_135612.jpg","link":"https://movie.naver.com/movie/bi/mi/basic.nhn?code=121051"},
      {"id":"8", "name":"양들의침묵","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0298/29848_P26_021534.jpg","link":"https://movie.naver.com/movie/bi/mi/basic.nhn?code=29848"},
      {"id":"9", "name":"렛미인","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0499/49957_P36_121355.jpg","link":"https://movie.naver.com/movie/bi/mi/basic.nhn?code=49957"},
      {"id":"10","name":"애나벨","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1273/127338_P11_135323.jpg","link":"https://movie.naver.com/movie/bi/mi/basic.nhn?code=127338"},
      {"id":"11","name":"이블데드","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0506/50636_P02_095218.jpg","link":"https://movie.naver.com/movie/bi/mi/basic.nhn?code=50636"},
      {"id":"12","name":"드래그미투헬","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0525/E2524-01.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=52524"},
    ];


    anilist =
    [{"id":"0", "name":"하울의 움직이는 성","url":"https://ssl.pstatic.net/imgmovie/mdi/mit110/0396/39640_P32_175320.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=39640"},
      {"id":"1", "name":"너의 이름은","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1501/150198_P60_142006.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=150198"},
      {"id":"2", "name":"시간을 달리는 소녀","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0635/63513_P23_163407.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=63513"},
      {"id":"3", "name":"센과치히로의 행방불명","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0326/32686_P47_105154.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=32686"},
      {"id":"4", "name":"이웃집토토로","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0187/18781_P40_110031.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=18781"},
      {"id":"5", "name":"도라에몽","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1842/184208_P08_170257.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=184208"},
      {"id":"6", "name":"월E","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0691/F9105-00.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=69105"},
      {"id":"7", "name":"라따뚜이","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0650/F5021-00.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=65021"},
      {"id":"8", "name":"라푼젤","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/0754/75470_P55_153307.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=75470"},
      {"id":"9", "name":"토이스토리","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1019/101966_P09_114632.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=101966"},
      {"id":"10","name":"겨울왕국","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1009/100931_P98_151621.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=100931"},
      {"id":"11","name":"인사이드아웃","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1156/115622_P24_095702.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=115622"},
      {"id":"12","name":"코코","url" : "https://ssl.pstatic.net/imgmovie/mdi/mit110/1517/151728_P21_103229.jpg","link": "https://movie.naver.com/movie/bi/mi/basic.nhn?code=151728"},
    ];

    resultlist = ['','','','','',''];
    //getmovie(movielist);
    _initMovielist();

  }

  //화면이 사라질때??? ok
  @override
  void dispose() {
    // TODO: implement dispose

    resultlist = [];
    urllist =[];

    super.dispose();
    print('dispose');

  }


  @override
  Widget build(BuildContext context) {

    print('scafolld called');
    return Scaffold(
      //appBar: AppBar(title: Text('tt'),),


      body: Container(
        color: Colors.grey[900],
        child: GridView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {

            String url = urllist[index]['url'] == null ? '' : urllist[index]['url'];
            int moviekind = index;
            //print('$index  url  $url' );

            List sendlist = [];
            if (index == 0){
              sendlist = movielist;

            }else if (index == 1){
              sendlist = romancelist;
            }else if (index == 2){
              sendlist = actionlist;
            }else if (index == 3){
              sendlist = horrorlist;
            }else if (index == 4){
              sendlist = dramalist;
            }else if (index == 5){
              sendlist = anilist;
            }else{
              sendlist = movielist;
            }
            //print('sendlist start');
            //print(sendlist);
            //print('sendlist end');
            //print('url $url');
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  //color: colorlist[index],//Colors.yellow[900],
                  width: 1,
                ),

                borderRadius: BorderRadius.circular(10),
              ),

              child: Card(
                //shape: ,
                elevation: 3,
                color: Colors.black,
                child: Column(
                  children: <Widget>[

                    Expanded(
                      flex: 7,
                      child: Container(

                          child: InkWell(
                            onTap:(){

                            /*
                             () =>   Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return MovieFightMain(moviekind:moviekind,getmovielist:sendlist);
                                })),
                            */
                            _showDialogyn(moviekind,sendlist);
                            },

                            child:url == '' ? Image.asset('assets/data/bgimg.png') :

                            FadeInImage.assetNetwork(
                              // here `bytes` is a Uint8List containing the bytes for the in-memory image,

                              placeholder: 'assets/data/bgimg.png',
                              width:200,
                              image: url,
                              fit: BoxFit.fill,
                            )
                            ,

                          )
                      )
                    ),
                    /*
                    FutureBuilder(
                      future: DefaultAssetBundle
                          .of(context)
                          .loadString('assets/data/result.json'),
                      builder: (context, snapshot) {
                        // Decode the JSON
                        var new_data = json.decode(snapshot.data.toString());
                        return Text(new_data[0]['url']);
                      }
                      ),*/

                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.grey[800],

                        child: ListTile(
                          title: Text(gamelist[index], textAlign:TextAlign.center,style: TextStyle(fontSize: 20,),),
                          subtitle: Text(resultlist[index], textAlign:TextAlign.center, style: TextStyle(fontSize: 15,),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            //childAspectRatio: .58,
            childAspectRatio: .57,
          ),
        ),
      ),
    );
  }


  // user defined function
  void _showDialogyn(moviekind,sendlist) {

    if (resultlist[moviekind] == null || resultlist[moviekind] ==''){
      //todo 처음 하면 바로 보내고 아니면 팝업으로 물어보기
      Navigator.push(context,
          MaterialPageRoute(builder: (context) {
            return MovieFightMain(moviekind:moviekind,getmovielist:sendlist);
          }));
    }else{
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("재미있었나요?"),
            content: new Text("다시 하시겠습니까?"),
            backgroundColor:Colors.deepPurple,
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("다시하기"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return MovieFightMain(moviekind:moviekind,getmovielist:sendlist);
                      }));
                },
              ),
              new FlatButton(
                child: new Text("영화정보확인"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return MyWebview(url:urllist[moviekind]['link'],title:resultlist[moviekind]);
                      }));
                },
              ),
            ],
          );
        },
      );
    }

  }


  void getmovie(List movielist){

    for(int i = 0; i < movielist.length ; i++){
      getmovieinfo(movielist[i]);
      //print(movielist[i]);
    }
  }


  //todo 로딩 끝나면 화면에 유알엘 적용해줘
  //todo 어떤 사이트로 보내야할지도 알려줘

  void getmovieinfo(Map<String,String> movieinfo) async{
    print("Request failed with status: ");

    String strings = movieinfo['name'];
    print("Request $strings");

    var encoded_query = Uri.encodeFull(strings);
    //String query = '%EC%A3%BC%EC%8B%9D';

    //print(decoded);
    //print(strings);

    var year =     (movieinfo['year']== null || movieinfo['year'] == '') ? '' : movieinfo['year'];
    var start =    (movieinfo['start']== null || movieinfo['start'] == '') ? '' : movieinfo['start'];
    var country =  (movieinfo['country']== null || movieinfo['country'] == '') ? '' : movieinfo['country'];
    var display =  (movieinfo['display']== null || movieinfo['display'] == '') ? '' : movieinfo['display'];

    var yearfrom = (movieinfo['yearfrom']== null || movieinfo['yearfrom'] == '') ? '' : movieinfo['yearfrom'];
    var yearto =   (movieinfo['yearto']== null || movieinfo['yearto'] == '') ? '' : movieinfo['yearto'];

    var finalurl = "https://openapi.naver.com/v1/search/movie.json?query=$encoded_query";

    if (start !='')    finalurl +"&start=$start";
    if (display !='')  finalurl +"&display=$display";
    if (country !='')  finalurl +"&country=$country";
    if (yearfrom !='' && yearto !='') finalurl +"&yearfrom=$yearfrom&yearto=$yearto";

    var headers = {"X-Naver-Client-Id": "1c58Nt7nhF38L6BnuiAS", "X-Naver-Client-Secret": "Es9Zr4cOUA" };

    //print("final url: $finalurl");

    // country = 'US';
    //String strings = "저수지의";

    //decodeUtf8(utf8.encode(strings));
    //var encoded_query2 = utf8.encode(strings);
    //var decoded = utf8.decode(encoded_query2);
    //var url = "https://openapi.naver.com/v1/search/movie.json?query=$encoded_query&display=10&start=1&country=US&yearfrom=1990&yearto=2019";

    var response = await http.get(finalurl,headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      //var movie_title = jsonResponse['items'].forEach( (x) => x['title']);
      var movie_title = jsonResponse['items'][0]['title'];
      var movie_link = jsonResponse['items'][0]['link'];
      var movie_img_url = jsonResponse['items'][0]['image'];

      //print(movie_title.replaceAll(new RegExp('/[^가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]/gi'),''));

      //int endindx = movie_title.toString().indexOf('</b>');

      //print("Number of books about http: $jsonResponse.");
      //print("movie_title: $movie_title");
      //print('movie_link: ,"link": "$movie_link"');
      //print("movie_img_url: $movie_img_url");

      Map<String,String> mapvar ={'link':movie_link,'image':movie_img_url};
      movieinfo.addAll(mapvar);

    } else {
      //print("Request failed with status: ${response.statusCode}.");
      Map<String,String> mapvar ={'link':'','image':''};
      movieinfo.addAll(mapvar);
    }
  }

}


