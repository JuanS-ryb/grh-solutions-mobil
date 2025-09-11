import 'package:flutter/material.dart';

ValueNotifier<bool> useDarkTheme = ValueNotifier(false);
ValueNotifier<int> renderNotificator = ValueNotifier(0);

// NUEVO: para controlar si el usuario está logeado o no
ValueNotifier<bool> isLoggedIn = ValueNotifier(true);
