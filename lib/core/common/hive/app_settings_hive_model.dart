import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../../../config/constants/hive/hive_tabel_constant.dart';

part 'app_settings_hive_model.g.dart';

@HiveType(
  typeId: HiveTableConstant.appSettingsTableId,
)
class AppSettingsHiveModel {
  @HiveField(0)
  final bool firstTime;

  @HiveField(1)
  final bool goHome;

  @HiveField(2)
  final bool server;

  @HiveField(3)
  final String? token;

  @HiveField(4)
  final bool offline;

  AppSettingsHiveModel({
    required this.firstTime,
    required this.goHome,
    required this.server,
    this.token,
    required this.offline,
  });

  factory AppSettingsHiveModel.empty() {
    return AppSettingsHiveModel(
      firstTime: true,
      goHome: false,
      server: false,
      token: null,
      offline: false,
    );
  }

  AppSettingsHiveModel copyWith({
    bool? firstTime,
    bool? goHome,
    bool? server,
    String? token,
    bool? offline,
  }) {
    return AppSettingsHiveModel(
      firstTime: firstTime ?? this.firstTime,
      goHome: goHome ?? this.goHome,
      server: server ?? this.server,
      token: token ?? this.token,
      offline: offline ?? this.offline,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'firstTime': firstTime});
    result.addAll({'goHome': goHome});
    result.addAll({'server': server});
    if (token != null) {
      result.addAll({'token': token});
    }
    result.addAll({'offline': offline});

    return result;
  }

  factory AppSettingsHiveModel.fromMap(Map<String, dynamic> map) {
    return AppSettingsHiveModel(
      firstTime: map['firstTime'] ?? false,
      goHome: map['goHome'] ?? false,
      server: map['server'] ?? false,
      token: map['token'],
      offline: map['offline'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppSettingsHiveModel.fromJson(String source) =>
      AppSettingsHiveModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'App Settings:\n'
        '  - First Time: $firstTime\n'
        '  - Go Home: $goHome\n'
        '  - Server: $server\n'
        '  - Offline: $offline\n'
        '  - Token: $token\n';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppSettingsHiveModel &&
        other.firstTime == firstTime &&
        other.goHome == goHome &&
        other.server == server &&
        other.offline == offline &&
        other.token == token;
  }

  @override
  int get hashCode {
    return firstTime.hashCode ^
        goHome.hashCode ^
        server.hashCode ^
        offline.hashCode ^
        token.hashCode;
  }
}
