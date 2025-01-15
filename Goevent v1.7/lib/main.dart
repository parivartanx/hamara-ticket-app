import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/app_route.dart';
// import 'splashscreen.dart';
import 'utils/app_color.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
   const ProviderScope(
     child: App(),
   )
    );
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Hamara Ticket',
      theme: ThemeData(
        primarySwatch: AppColors.primarySwatch,
      ),
      routerConfig: appRouter,
    );
    // return MaterialApp(
    //   title: 'Hamara Ticket',
    //   theme: ThemeData(
    //     primarySwatch: AppColors.primarySwatch,
    //   ),
    //   home: const Splashscreen(),
    // );  
    
  }
}
