// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResidentBlock {
  final String uid;
  final String socCode;
  final String flatBlock;
  ResidentBlock({
    required this.uid,
    required this.socCode,
    required this.flatBlock,
  });

  ResidentBlock copyWith({
    String? uid,
    String? socCode,
    String? flatBlock,
  }) {
    return ResidentBlock(
      uid: uid ?? this.uid,
      socCode: socCode ?? this.socCode,
      flatBlock: flatBlock ?? this.flatBlock,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'socCode': socCode,
      'flatBlock': flatBlock,
    };
  }

  factory ResidentBlock.fromMap(Map<String, dynamic> map) {
    return ResidentBlock(
      uid: map['UID'] as String,
      socCode: map['Soc_Code'] as String,
      flatBlock: map['Flat_Block'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResidentBlock.fromJson(String source) =>
      ResidentBlock.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ResidentBlock(uid: $uid, socCode: $socCode, flatBlock: $flatBlock)';

  @override
  bool operator ==(covariant ResidentBlock other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.socCode == socCode &&
        other.flatBlock == flatBlock;
  }

  @override
  int get hashCode => uid.hashCode ^ socCode.hashCode ^ flatBlock.hashCode;
}
