// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewScreen extends StatefulWidget {
//   final String url;
//
//   WebViewScreen({required this.url});
//
//   @override
//   _WebViewScreenState createState() => _WebViewScreenState();
// }
//
// class _WebViewScreenState extends State<WebViewScreen> {
//   late WebViewController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     // Enable hybrid composition for Android (for better WebView performance)
//     if (WebView.platform == null && Theme.of(context).platform == TargetPlatform.android) {
//       WebView.platform = SurfaceAndroidWebView();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Playing on Spotify'),
//       ),
//       body: WebView(
//         initialUrl: widget.url,
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (WebViewController webViewController) {
//           _controller = webViewController;
//         },
//       ),
//     );
//   }
// }
