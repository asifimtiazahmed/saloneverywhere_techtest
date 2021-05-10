import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExplorer extends StatefulWidget {
  @override
  _WebViewExplorerState createState() => _WebViewExplorerState();
}

class _WebViewExplorerState extends State<WebViewExplorer> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Image.asset('./Assets/salonLogo.png'),
        actions: [
          MaterialButton(
              child: Icon(
                Icons.chevron_left,
                color: Colors.red[800],
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/dashboard');
              })
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: 'https://saloneverywhere.com/sample-profiles',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print('WebView is loading (progress: $progress%)');
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://saloneverywhere.com')) {
              //Resricting all access to web except to SaloonEverywhere domain
              print('allowing navigation to $request');
              return NavigationDecision.navigate;
            } else
              return NavigationDecision.prevent;
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }
}
