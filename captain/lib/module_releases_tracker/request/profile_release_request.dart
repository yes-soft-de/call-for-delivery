import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

enum PlatformOS {
  android,
  ios;

  int get toInt {
    switch (this) {
      case PlatformOS.android:
        return 0;
      case PlatformOS.ios:
        return 1;
    }
  }
}

class ProfileReleaseRequest {
  String version;
  PlatformOS platformOS;

  ProfileReleaseRequest({
    required this.version,
    required this.platformOS,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'releaseVersion': version,
      'platformOS': platformOS.toInt,
    };
  }

  String toJson() => json.encode(toMap());
}
