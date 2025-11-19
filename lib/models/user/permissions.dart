class Ident {
  final String method; // "GET" | "POST" | ...
  final String originalUrl;
  final Module? module;

  Ident({
    required this.method,
    required this.originalUrl,
    this.module,
  });

  factory Ident.fromJson(Map<String, dynamic> json) => Ident(
    method: json['method'],
    originalUrl: json['originalUrl'],
    module:
    json['module'] != null ? Module.fromJson(json['module']) : null,
  );

  Map<String, dynamic> toJson() => {
    'method': method,
    'originalUrl': originalUrl,
    'module': module?.toJson(),
  };
}

class Module {
  final String name;
  final String disabled;
  final String description;

  Module({
    required this.name,
    required this.disabled,
    required this.description,
  });

  factory Module.fromJson(Map<String, dynamic> json) => Module(
    name: json['name'],
    disabled: json['disabled'],
    description: json['description'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'disabled': disabled,
    'description': description,
  };
}

class VerifiedPermission {
  final bool success;
  final List<PermissionItem> permissions;

  VerifiedPermission({
    required this.success,
    required this.permissions,
  });

  factory VerifiedPermission.fromJson(Map<String, dynamic> json) =>
      VerifiedPermission(
        success: json['success'],
        permissions: (json['permissions'] as List)
            .map((e) => PermissionItem.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    'success': success,
    'permissions': permissions.map((e) => e.toJson()).toList(),
  };
}

class PermissionItem {
  final Ident ident;
  final bool granted;

  PermissionItem({
    required this.ident,
    required this.granted,
  });

  factory PermissionItem.fromJson(Map<String, dynamic> json) =>
      PermissionItem(
        ident: Ident.fromJson(json['ident']),
        granted: json['granted'],
      );

  Map<String, dynamic> toJson() => {
    'ident': ident.toJson(),
    'granted': granted,
  };
}
