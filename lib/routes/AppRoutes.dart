import 'package:bunker/screens/admin/tickets.dart';
import 'package:bunker/screens/home/home.dart';
import 'package:bunker/screens/support/create_ticket.dart';
import 'package:bunker/screens/welcome/welcome_screen.dart';
import 'package:go_router/go_router.dart';

import '../screens/loading_screens/loading_screens.dart';

class AppRoutes {

  static const String welcome = "/welcome";
  static const String home = "/home";
  static const String createTicket = "/createTicket";
  static const loadingScreen="/loadingScreen";
  static const adminWithdrawalTickets="/adminWithdrawalTickets";


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
      GoRoute(
        path: createTicket,
        builder: (context, state) =>  CreateTicket(),
      ),
      GoRoute(
        path: adminWithdrawalTickets,
        builder: (context, state) =>  Tickets(),
      ),
      GoRoute(
          path: loadingScreen,
          builder: (context, state){
            final args=state.extra as Map;
            return LoadingScreen(callBack: args['callBack'],message: args['message'],);
          }
      ),
    ],
  );
}