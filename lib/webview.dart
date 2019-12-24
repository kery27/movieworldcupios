import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebview extends StatelessWidget {

  String url;
  String title;

  MyWebview({Key key, this.url, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('url $url');
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (String url) {
          print('finished:');
        },
      ),
    );
  }
}
