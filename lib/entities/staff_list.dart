// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StaffList {
  final String uid;
  final String socCode;
  final String staffName;
  final String staffIcon;
  final String staffIsActive;
  StaffList({
    required this.uid,
    required this.socCode,
    required this.staffName,
    required this.staffIcon,
    required this.staffIsActive,
  });

  StaffList copyWith({
    String? uid,
    String? socCode,
    String? staffName,
    String? staffIcon,
    String? staffIsActive,
  }) {
    return StaffList(
      uid: uid ?? this.uid,
      socCode: socCode ?? this.socCode,
      staffName: staffName ?? this.staffName,
      staffIcon: staffIcon ?? this.staffIcon,
      staffIsActive: staffIsActive ?? this.staffIsActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'socCode': socCode,
      'staffName': staffName,
      'staffIcon': staffIcon,
      'staffIsActive': staffIsActive,
    };
  }

  factory StaffList.fromMap(Map<String, dynamic> map) {
    return StaffList(
      uid: map['uid'] as String,
      socCode: map['soc_code'] as String,
      staffName: map['staff_name'] as String,
      staffIcon: map['staff_icon'] as String,
      staffIsActive: map['staff_is_active'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StaffList.fromJson(String source) =>
      StaffList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StaffList(uid: $uid, socCode: $socCode, staffName: $staffName, staffIcon: $staffIcon, staffIsActive: $staffIsActive)';
  }

  @override
  bool operator ==(covariant StaffList other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.socCode == socCode &&
        other.staffName == staffName &&
        other.staffIcon == staffIcon &&
        other.staffIsActive == staffIsActive;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        socCode.hashCode ^
        staffName.hashCode ^
        staffIcon.hashCode ^
        staffIsActive.hashCode;
  }
}
