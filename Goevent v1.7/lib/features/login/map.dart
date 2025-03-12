// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewContainer extends StatefulWidget {
//   final url;
//
//   WebViewContainer(this.url);
//
//   @override
//   createState() => _WebViewContainerState(this.url);
// }
//
// class Body extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return LinearProgressIndicator(backgroundColor: Colors.lightBlue);
//   }
// }
//
// class _WebViewContainerState extends State<WebViewContainer> {
//   var _url;
//   final _key = UniqueKey();
//   _WebViewContainerState(this._url);
//
//   num position = 1;
//
//   doneLoading() {
//     setState(() {
//       position = 0;
//     });
//   }
//
//   startLoading() {
//     setState(() {
//       position = 1;
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Body(),
//             Expanded(
//               child: WebView(
//                 key: _key,
//                 javascriptMode: JavascriptMode.unrestricted,
//                 initialUrl: _url,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
