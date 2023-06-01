import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  late bool notificationStatus = true;

  void buttonChange(value) {
    notificationStatus = value;
    ;
  }
}
