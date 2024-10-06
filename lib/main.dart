import 'package:bunker/routes/AppRoutes.dart';
import 'package:bunker/screens/account/controller/account_setting_controller.dart';
import 'package:bunker/screens/home/controller/home_controller.dart';
import 'package:bunker/supported_assets/controller/asset_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'components/Apptheme.dart';
import 'controller/theme_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => AssetController()),
        ChangeNotifierProvider(create: (_) => AccountSettingController()),
      ],
      child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          ensureScreenSize: true,
          builder: (BuildContext context, Widget? child) {
            return Consumer<ThemeController>(
              builder: (context, themeController, child) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  theme: themeController.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
                  routerConfig: AppRoutes.router,
                );
              },
            );
          }
      ),
    );
  }
}
