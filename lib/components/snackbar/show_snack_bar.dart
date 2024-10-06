import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar/top_snackbar.dart';

class ShowSnackBar{

  static void show(BuildContext context,String message,Color color){
    CustomTopSnackbar.show(
      context,
       message,
      // Customize more additional properties as required (optional)
      leadingIcon: Icons.info,
      backgroundColor: color,
      borderColor: color,
    );
  }
}