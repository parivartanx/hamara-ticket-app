import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/utils/shared_prefs_manager.dart';
import 'config/app_route.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import '/providers/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsManager.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Hamara Ticket',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: themeState.primaryColor,
            colorScheme: ColorScheme.light(
              primary: themeState.primaryColor,
              secondary: themeState.secondaryColor,
              surface: themeState.surfaceColor,
              onSurface: themeState.textColor,
            ),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: themeState.primaryColor,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Gilroy',
              ),
            ),
          ),
          routerConfig: appRouter,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                primaryColor: themeState.primaryColor,
                colorScheme: ColorScheme.light(
                  primary: themeState.primaryColor,
                  secondary: themeState.secondaryColor,
                  surface: themeState.surfaceColor,
                  onSurface: themeState.textColor,
                ),
                appBarTheme: AppBarTheme(
                  backgroundColor: themeState.primaryColor,
                  elevation: 0,
                  centerTitle: true,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Gilroy',
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}
