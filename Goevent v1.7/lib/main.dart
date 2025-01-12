import 'package:flutter/material.dart';
import 'package:goevent2/splashscreen.dart';
import 'package:provider/provider.dart';
import 'utils/colornotifire.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ColorNotifire(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        
        home: Splashscreen(),
      ),
    ),
  );
}
