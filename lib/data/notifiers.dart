import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grhsolutions/models/user/login-model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user/permissions.dart';

ValueNotifier<bool> useDarkTheme = ValueNotifier(false);
ValueNotifier<int> renderNotificator = ValueNotifier(0);

// NUEVO: para controlar si el usuario está logeado o no
ValueNotifier<bool> isLoggedIn = ValueNotifier(false);

// controlador de login
ValueNotifier<AuthResponse?> loginController = ValueNotifier<AuthResponse?>(null);

// VALUE NOTIFIER PARA ALMACENAR LOS DATOS DE PERMISOS DEL USUARIO
final PermissionsNotifier permissions = PermissionsNotifier();

class PermissionsNotifier extends ValueNotifier<VerifiedPermission> {
  static final PermissionsNotifier _instance =
  PermissionsNotifier._internal();

  factory PermissionsNotifier() => _instance;

  PermissionsNotifier._internal()
      : super(VerifiedPermission(success: false, permissions: [])) {
    _loadFromPrefs();
  }

  static const _key = 'user_permissions_data';

  /// ================================================================
  /// CARGAR DESDE SHARED PREFERENCES
  /// ================================================================
  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) return;

    try {
      final jsonMap = jsonDecode(jsonString);
      value = VerifiedPermission.fromJson(jsonMap);
    } catch (e) {
      debugPrint("Error al cargar permisos: $e");
    }
  }

  /// ================================================================
  /// GUARDAR SOLO LOS PERMISOS (Ident + granted)
  /// ================================================================
  Future<void> _saveToPrefs(VerifiedPermission permission) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = jsonEncode({
      "success": true,
      "permissions": permission.permissions
          .map((p) => p.toJson())
          .toList(),
    });

    await prefs.setString(_key, jsonString);
  }

  /// Actualiza permisos en memoria y almacenamiento
  Future<void> updatePermissions(VerifiedPermission newPerms) async {
    value = newPerms;
    await _saveToPrefs(newPerms);
  }

  /// ================================================================
  /// CLEAR PERMISSIONS
  /// ================================================================
  Future<void> clearPermissions() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);

    value = VerifiedPermission(success: false, permissions: []);
  }

  /// ================================================================
  /// CHECK PERMISSION POR IDENT
  /// ================================================================
  Future<bool> checkPermission(Ident checkThis) async {
    final perms = value.permissions;

    for (var p in perms) {
      final ident = p.ident;

      final bool same =
          ident.method == checkThis.method &&
              ident.originalUrl == checkThis.originalUrl &&
              ((ident.module == null && checkThis.module == null) ||
                  (ident.module != null &&
                      checkThis.module != null &&
                      ident.module!.name == checkThis.module!.name));

      if (same) return p.granted;
    }

    return false;
  }

  /// ================================================================
  /// MÉTODO RÁPIDO: can("GET", "/ruta")
  /// ================================================================
  Future<bool> can(String method, String url, {String? moduleName}) async {
    final ident = Ident(
      method: method,
      originalUrl: url,
      module: moduleName != null
          ? Module(name: moduleName, disabled: "", description: "")
          : null,
    );

    return await checkPermission(ident);
  }

  /// ================================================================
  /// MÉTODO: Verificar si tiene permiso por módulo
  /// ================================================================
  Future<bool> canModule(String moduleName) async {
    for (var p in value.permissions) {
      if (p.ident.module?.name == moduleName && p.granted) {
        return true;
      }
    }
    return false;
  }
}
