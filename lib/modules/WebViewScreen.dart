import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {

  final String url ;

  WebViewScreen(this.url, {super.key});

  late final WebViewController controller = WebViewController()..loadRequest(
    Uri.parse(this.url),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewsApp',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: WebViewWidget(controller: controller)
    );
  }
}
