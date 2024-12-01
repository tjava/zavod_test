import 'package:zavod_test/core/constants/colors_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zavod_test/navigator/router.dart';

class MainZavodTest extends StatelessWidget {
  const MainZavodTest({super.key});

  static final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Zavod Test',
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: white,
            appBarTheme: const AppBarTheme(
              backgroundColor: white,
              centerTitle: true,
              elevation: 0,
            ),
          ),
          routerConfig: appRouter.config(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
