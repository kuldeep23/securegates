// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StaffList {
  final String uid;
  final String socCode;
  final String staffType;
  final String staffIcon;
  final String count;
  StaffList({
    required this.uid,
    required this.socCode,
    required this.staffType,
    required this.staffIcon,
    required this.count,
  });

  StaffList copyWith({
    String? uid,
    String? socCode,
    String? staffType,
    String? staffIcon,
    String? count,
  }) {
    return StaffList(
      uid: uid ?? this.uid,
      socCode: socCode ?? this.socCode,
      staffType: staffType ?? this.staffType,
      staffIcon: staffIcon ?? this.staffIcon,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'socCode': socCode,
      'staffType': staffType,
      'staffIcon': staffIcon,
      'count': count,
    };
  }

  factory StaffList.fromMap(Map<String, dynamic> map) {
    return StaffList(
      uid: map['uid'] as String,
      socCode: map['soc_code'] as String,
      staffType: map['staff_type'] as String,
      staffIcon: map['staff_icon'] as String,
      count: map['count'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StaffList.fromJson(String source) =>
      StaffList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StaffList(uid: $uid, socCode: $socCode, staffType: $staffType, staffIcon: $staffIcon, count: $count)';
  }

  @override
  bool operator ==(covariant StaffList other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.socCode == socCode &&
        other.staffType == staffType &&
        other.staffIcon == staffIcon &&
        other.count == count;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        socCode.hashCode ^
        staffType.hashCode ^
        staffIcon.hashCode ^
        count.hashCode;
  }
}
