import 'package:flutter/material.dart';
import 'package:grhsolutions/models/user/login-model.dart';

ValueNotifier<bool> useDarkTheme = ValueNotifier(false);
ValueNotifier<int> renderNotificator = ValueNotifier(0);

// NUEVO: para controlar si el usuario está logeado o no
ValueNotifier<bool> isLoggedIn = ValueNotifier(false);

// controlador de login
ValueNotifier<AuthResponse?> loginController = ValueNotifier<AuthResponse?>(null);