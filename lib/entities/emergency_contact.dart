// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EmergencyDirectoryContact {
  final String uid;
  final String socCode;
  final String directoryType;
  final String personName;
  final String personNumber;
  final String isActive;
  EmergencyDirectoryContact({
    required this.uid,
    required this.socCode,
    required this.directoryType,
    required this.personName,
    required this.personNumber,
    required this.isActive,
  });

  EmergencyDirectoryContact copyWith({
    String? uid,
    String? socCode,
    String? directoryType,
    String? personName,
    String? personNumber,
    String? isActive,
  }) {
    return EmergencyDirectoryContact(
      uid: uid ?? this.uid,
      socCode: socCode ?? this.socCode,
      directoryType: directoryType ?? this.directoryType,
      personName: personName ?? this.personName,
      personNumber: personNumber ?? this.personNumber,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'socCode': socCode,
      'directoryType': directoryType,
      'personName': personName,
      'personNumber': personNumber,
      'isActive': isActive,
    };
  }

  factory EmergencyDirectoryContact.fromMap(Map<String, dynamic> map) {
    return EmergencyDirectoryContact(
      uid: map['uid'] as String,
      socCode: map['soc_code'] as String,
      directoryType: map['directory_type'] as String,
      personName: map['person_name'] as String,
      personNumber: map['person_number'] as String,
      isActive: map['is_active'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmergencyDirectoryContact.fromJson(String source) =>
      EmergencyDirectoryContact.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EmergencyContact(uid: $uid, socCode: $socCode, directoryType: $directoryType, personName: $personName, personNumber: $personNumber, isActive: $isActive)';
  }

  @override
  bool operator ==(covariant EmergencyDirectoryContact other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.socCode == socCode &&
        other.directoryType == directoryType &&
        other.personName == personName &&
        other.personNumber == personNumber &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        socCode.hashCode ^
        directoryType.hashCode ^
        personName.hashCode ^
        personNumber.hashCode ^
        isActive.hashCode;
  }
}
