import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('네이버 영화'),),
      body: WebView(
        initialUrl: 'https://movie.naver.com',
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (String url) {
          print('finished:');
        },
      ),
    );
  }
}
