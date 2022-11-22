import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  const WebViewWidget({super.key, required this.title, required this.url});

  final String title;
  final String url;

  @override
  WebViewWidgetState createState() => WebViewWidgetState();
}

class WebViewWidgetState extends State<WebViewWidget> {
  int _progress = 0;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.5,
        ),
        body: Builder(builder: (_) {
          if (widget.url.isEmpty) {
            return const Center(
              child: Text('Homepage is empty'),
            );
          }

          return Stack(
            children: [
              WebView(
                initialUrl: widget.url,
                onProgress: (progress) {
                  setState(() {
                    _progress = progress;
                  });
                },
              ),
              _progress < 100
                  ? const Positioned.fill(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const SizedBox(),
            ],
          );
        }),
      );
    });
  }
}
