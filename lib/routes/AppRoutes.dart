import 'package:bunker/screens/admin/deposit/deposit_page.dart';
import 'package:bunker/screens/admin/support/admin_support_ticket.dart';
import 'package:bunker/screens/admin/tickets.dart';
import 'package:bunker/screens/admin/user_email_screen.dart';
import 'package:bunker/screens/home/home.dart';
import 'package:bunker/screens/landing_page/landing_page.dart';
import 'package:bunker/screens/support/create_ticket.dart';
import 'package:bunker/screens/welcome/welcome_screen.dart';
import 'package:bunker/supported_assets/model/assets.dart';
import 'package:go_router/go_router.dart';

import '../screens/loading_screens/loading_screens.dart';

class AppRoutes {

  static const landingPage="/landingPage";
  static const String welcome = "/welcome";
  static const String home = "/home";
  static const loadingScreen="/loadingScreen";
  static const adminWithdrawalTickets="/adminWithdrawalTickets";
  static const userEmailScreen="/userEmailScreen";
  static const supportTickets="/supportTickets";
  static const depositPage="/depositPage";


  static final router = GoRouter(
    initialLocation: home.toString(),
    routes: [
      GoRoute(
        path: landingPage,
        builder: (context, state) =>  LandingPage(),
      ),
      GoRoute(
        path: welcome,
        builder: (context, state) =>  WelcomeScreen(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) =>  Home(),
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
      GoRoute(
          path: userEmailScreen,
          builder: (context, state){
            return UserEmailScreen();
          }
      ),
      GoRoute(
          path: depositPage,
          builder: (context, state){
            final args=state.extra as List<AssetModel>;
            return DepositPage(assets: args);
          }
      ),
      GoRoute(
          path: supportTickets,
          builder: (context, state){
            return AdminSupportTicket();
          }
      ),
    ],
  );
}