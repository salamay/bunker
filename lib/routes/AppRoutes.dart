
import 'dart:developer';

import 'package:bunker/screens/admin/deposit/deposit_page.dart';
import 'package:bunker/screens/admin/support/admin_support_ticket.dart';
import 'package:bunker/screens/admin/tickets.dart';
import 'package:bunker/screens/admin/user_email_screen.dart';
import 'package:bunker/screens/home/home.dart';
import 'package:bunker/screens/landing_page/landing_page.dart';
import 'package:bunker/screens/registration/registration_screen.dart';
import 'package:bunker/screens/registration/reset_password.dart';
import 'package:bunker/screens/support/create_ticket.dart';
import 'package:bunker/screens/wallet/receive.dart';
import 'package:bunker/screens/welcome/welcome_screen.dart';
import 'package:bunker/screens_mobile/home/home_mobile.dart';
import 'package:bunker/screens_mobile/registration/reset_password_mobile.dart';
import 'package:bunker/screens_mobile/welcome/welcome_screen_mobile.dart';
import 'package:bunker/supported_assets/model/assets.dart';
import 'package:bunker/utils/size_utils.dart';
import 'package:go_router/go_router.dart';

import '../screens/loading_screens/loading_screens.dart';
import '../screens/otp_screen/model/otp_args.dart';
import '../screens/otp_screen/otp_screen.dart';
import '../screens/registration/email_sent.dart';
import '../screens/registration/send_reset_pass_email.dart';
import '../screens_mobile/registration/email_sent_mobile.dart';
import '../screens_mobile/registration/registration_screen_mobile.dart';
import '../screens_mobile/registration/send_reset_pass_email.dart';

class AppRoutes {

  static const landingPage="/landingPage";
  static const String welcome = "/welcome";
  static const String registration = "/registration";
  static const String emailSent = "/emailSent";
  static const String home = "/home";
  static const String receive = "/receive";
  static const loadingScreen="/loadingScreen";
  static const adminWithdrawalTickets="/adminWithdrawalTickets";
  static const userEmailScreen="/userEmailScreen";
  static const supportTickets="/supportTickets";
  static const depositPage="/depositPage";
  static const otpScreen="/otpScreen";
  static const sendResetPassEmail="/sendResetPassEmail";
  static const resetPassword="/resetPassword/:code/:email";

  static final router = GoRouter(
    initialLocation: welcome.toString(),
    routes: [
      GoRoute(
        path: landingPage,
        builder: (context, state) =>  LandingPage(),
      ),
      GoRoute(
        path: registration,
        builder: (context, state) =>  SizeUtils.isMobileView(context)?RegistrationScreenMobile():RegistrationScreen(),
      ),
      GoRoute(
        path: emailSent,
        builder: (context, state) =>  SizeUtils.isMobileView(context)?EmailSentMobile():EmailSent(),
      ),
      GoRoute(
        path: welcome,
        builder: (context, state) =>  SizeUtils.isMobileView(context)?WelcomeScreenMobile():WelcomeScreen(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) =>  SizeUtils.isMobileView(context)?HomeMobile():Home(),
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
          path: receive,
          builder: (context, state){
            final args=state.extra as AssetModel;
            return Receive(asset: args);
          }
      ),
      GoRoute(
          path: supportTickets,
          builder: (context, state){
            return AdminSupportTicket();
          }
      ),
      GoRoute(
          path: sendResetPassEmail,
          builder: (context, state){
            return SizeUtils.isMobileView(context)?SendResetPassEmailMobile():SendResetPassEmail();
          }
      ),
      GoRoute(
          path: resetPassword,
          builder: (context, state){
            String? code=state.pathParameters['code'];
            String? email=state.pathParameters['email'];
            return SizeUtils.isMobileView(context)?ResetPasswordMobile(email: email!,code: code!,):ResetPassword(email: email!,code: code!,);
          }
      ),
      GoRoute(
          path: otpScreen,
          builder: (context, state){
            final otpArgs=state.extra as OtpArgs;
            return OtpScreen(otpArgs: otpArgs);
          }
      ),
    ],
  );
}