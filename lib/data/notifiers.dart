import 'package:flutter/material.dart';
import 'package:grhsolutions/models/user/login-model.dart';

ValueNotifier<bool> useDarkTheme = ValueNotifier(true);
ValueNotifier<int> renderNotificator = ValueNotifier(0);

// NUEVO: para controlar si el usuario está logeado o no
ValueNotifier<bool> isLoggedIn = ValueNotifier(false);

// controlador de login
ValueNotifier<LoginResponse?> loginController = ValueNotifier<LoginResponse?>(null);
