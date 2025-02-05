import 'package:flutter/material.dart';

ColorScheme colorScheme(context) => Theme.of(context).colorScheme;

TextTheme textTheme(context) => Theme.of(context).textTheme;

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

const String isFirstTimeText = 'isFirstTime';
const String isClientText = 'isClient';
const String isLoggedInText = 'isLoggedIn';
const String emailText = 'email';
const String isGuestText = 'isGuest';
const String passwordText = 'password';
