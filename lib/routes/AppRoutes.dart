import 'package:bunker/screens/home/home.dart';
import 'package:bunker/screens/welcome/welcome_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {

  static const String welcome = "/welcome";
  static const String home = "/home";


  static final router = GoRouter(
    initialLocation: home.toString(),
    routes: [
      GoRoute(
        path: welcome,
        builder: (context, state) =>  WelcomeScreen(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) =>  Home(),
      ),

    ],
  );
}