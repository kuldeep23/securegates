// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResidentFlat {
  final String uid;
  final String socCode;
  final String flatBlock;
  final String flatNumber;
  final String flatFloor;
  ResidentFlat({
    required this.uid,
    required this.socCode,
    required this.flatBlock,
    required this.flatNumber,
    required this.flatFloor,
  });

  ResidentFlat copyWith({
    String? uid,
    String? socCode,
    String? flatBlock,
    String? flatNumber,
    String? flatFloor,
  }) {
    return ResidentFlat(
      uid: uid ?? this.uid,
      socCode: socCode ?? this.socCode,
      flatBlock: flatBlock ?? this.flatBlock,
      flatNumber: flatNumber ?? this.flatNumber,
      flatFloor: flatFloor ?? this.flatFloor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'socCode': socCode,
      'flatBlock': flatBlock,
      'flatNumber': flatNumber,
      'flatFloor': flatFloor,
    };
  }

  factory ResidentFlat.fromMap(Map<String, dynamic> map) {
    return ResidentFlat(
      uid: map['UID'] as String,
      socCode: map['Soc_Code'] as String,
      flatBlock: map['Flat_Block'] as String,
      flatNumber: map['Flat_Number'] as String,
      flatFloor: map['Flat_Floor'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResidentFlat.fromJson(String source) =>
      ResidentFlat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResidentFlat(uid: $uid, socCode: $socCode, flatBlock: $flatBlock, flatNumber: $flatNumber, flatFloor: $flatFloor)';
  }

  @override
  bool operator ==(covariant ResidentFlat other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.socCode == socCode &&
        other.flatBlock == flatBlock &&
        other.flatNumber == flatNumber &&
        other.flatFloor == flatFloor;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        socCode.hashCode ^
        flatBlock.hashCode ^
        flatNumber.hashCode ^
        flatFloor.hashCode;
  }
}
