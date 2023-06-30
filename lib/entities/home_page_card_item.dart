// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HomePageCardItem {
  final String uid;
  final String featureName;
  final String featureIcon;
  final String featureSoc;
  final String featureColor;
  HomePageCardItem({
    required this.uid,
    required this.featureName,
    required this.featureIcon,
    required this.featureSoc,
    required this.featureColor,
  });

  HomePageCardItem copyWith({
    String? uid,
    String? featureName,
    String? featureIcon,
    String? featureSoc,
    String? featureColor,
  }) {
    return HomePageCardItem(
      uid: uid ?? this.uid,
      featureName: featureName ?? this.featureName,
      featureIcon: featureIcon ?? this.featureIcon,
      featureSoc: featureSoc ?? this.featureSoc,
      featureColor: featureColor ?? this.featureColor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'featureName': featureName,
      'featureIcon': featureIcon,
      'featureSoc': featureSoc,
      'featureColor': featureColor,
    };
  }

  factory HomePageCardItem.fromMap(Map<String, dynamic> map) {
    return HomePageCardItem(
      uid: map['uid'] as String,
      featureName: map['feature_name'] as String,
      featureIcon: map['feature_icon'] as String,
      featureSoc: map['feature_soc'] as String,
      featureColor: map['feature_color'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomePageCardItem.fromJson(String source) =>
      HomePageCardItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HomePageCardItem(uid: $uid, featureName: $featureName, featureIcon: $featureIcon, featureSoc: $featureSoc, featureColor: $featureColor)';
  }

  @override
  bool operator ==(covariant HomePageCardItem other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.featureName == featureName &&
        other.featureIcon == featureIcon &&
        other.featureSoc == featureSoc &&
        other.featureColor == featureColor;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        featureName.hashCode ^
        featureIcon.hashCode ^
        featureSoc.hashCode ^
        featureColor.hashCode;
  }
}
