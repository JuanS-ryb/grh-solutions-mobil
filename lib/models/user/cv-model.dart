// ---------------------- Skill ----------------------
class Skill {
  final int index;
  final String name;
  final String level;

  Skill({
    required this.index,
    required this.name,
    required this.level,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      index: json['index'],
      name: json['name'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() => {
    'index': index,
    'name': name,
    'level': level,
  };
}

// ---------------------- Language ----------------------
class Language {
  final int index;
  final String name;
  final String level;

  Language({
    required this.index,
    required this.name,
    required this.level,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      index: json['index'],
      name: json['name'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() => {
    'index': index,
    'name': name,
    'level': level,
  };
}

// ---------------------- Formation ----------------------
class Formation {
  final int index;
  final String tittle;
  final String school;
  final String city;
  final DateTime startDate;
  final DateTime? endDate;
  final bool finished;
  final String? descroption;

  Formation({
    required this.index,
    required this.tittle,
    required this.school,
    required this.city,
    required this.startDate,
    this.endDate,
    required this.finished,
    this.descroption,
  });

  factory Formation.fromJson(Map<String, dynamic> json) {
    return Formation(
      index: json['index'],
      tittle: json['tittle'],
      school: json['school'],
      city: json['city'],
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      finished: json['finished'],
      descroption: json['descroption'],
    );
  }

  Map<String, dynamic> toJson() => {
    'index': index,
    'tittle': tittle,
    'school': school,
    'city': city,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate?.toIso8601String(),
    'finished': finished,
    'descroption': descroption,
  };
}

// ---------------------- CV ----------------------
class CV {
  final String firstName;
  final String? middleName;
  final String lastName;
  final String? secondLastName;
  final String mail;
  final String phone;
  final String? address;
  final String? postal;
  final String? city;
  final DateTime? birthDay;
  final String? perfil;
  final List<Formation> formations;
  final List<Skill> skills;
  final List<Language> lenguages;
  final String fromUser; // ID del usuario

  CV({
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.secondLastName,
    required this.mail,
    required this.phone,
    this.address,
    this.postal,
    this.city,
    this.birthDay,
    this.perfil,
    this.formations = const [],
    this.skills = const [],
    this.lenguages = const [],
    required this.fromUser,
  });

  factory CV.fromJson(Map<String, dynamic> json) {
    return CV(
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      secondLastName: json['secondLastName'],
      mail: json['mail'],
      phone: json['phone'],
      address: json['address'],
      postal: json['postal'],
      city: json['city'],
      birthDay: json['birthDay'] != null ? DateTime.parse(json['birthDay']) : null,
      perfil: json['perfil'],
      formations: (json['formations'] as List<dynamic>?)
          ?.map((e) => Formation.fromJson(e))
          .toList() ??
          [],
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => Skill.fromJson(e))
          .toList() ??
          [],
      lenguages: (json['lenguages'] as List<dynamic>?)
          ?.map((e) => Language.fromJson(e))
          .toList() ??
          [],
      fromUser: json['fromUser'],
    );
  }

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'middleName': middleName,
    'lastName': lastName,
    'secondLastName': secondLastName,
    'mail': mail,
    'phone': phone,
    'address': address,
    'postal': postal,
    'city': city,
    'birthDay': birthDay?.toIso8601String(),
    'perfil': perfil,
    'formations': formations.map((f) => f.toJson()).toList(),
    'skills': skills.map((s) => s.toJson()).toList(),
    'lenguages': lenguages.map((l) => l.toJson()).toList(),
    'fromUser': fromUser,
  };
}
