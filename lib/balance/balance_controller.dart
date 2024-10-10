import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../api/my_api.dart';
import '../api/url/Api_url.dart';
import '../supported_assets/network_constants.dart';
import '../token_factory/token_factory.dart';
import 'model/CoinBalance.dart';
import 'model/price_quotes.dart';
import 'dart:math' as math;

class BalanceController extends ChangeNotifier {

  final my_api = MyApi();


}