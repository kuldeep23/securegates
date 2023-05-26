// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CarouselItem {
  final String uid;
  final String bannerImage;
  final String creationDate;
  final String isActive;
  CarouselItem({
    required this.uid,
    required this.bannerImage,
    required this.creationDate,
    required this.isActive,
  });

  CarouselItem copyWith({
    String? uid,
    String? bannerImage,
    String? creationDate,
    String? isActive,
  }) {
    return CarouselItem(
      uid: uid ?? this.uid,
      bannerImage: bannerImage ?? this.bannerImage,
      creationDate: creationDate ?? this.creationDate,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'bannerImage': bannerImage,
      'creationDate': creationDate,
      'isActive': isActive,
    };
  }

  factory CarouselItem.fromMap(Map<String, dynamic> map) {
    return CarouselItem(
      uid: map['UID'] as String,
      bannerImage: map['Banner_Image'] as String,
      creationDate: map['Creation_Date'] as String,
      isActive: map['Is_Active'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarouselItem.fromJson(String source) =>
      CarouselItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CarouselItem(uid: $uid, bannerImage: $bannerImage, creationDate: $creationDate, isActive: $isActive)';
  }

  @override
  bool operator ==(covariant CarouselItem other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.bannerImage == bannerImage &&
        other.creationDate == creationDate &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        bannerImage.hashCode ^
        creationDate.hashCode ^
        isActive.hashCode;
  }
}
