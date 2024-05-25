// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VisitorFromNotification {
  final String visitorName;
  final String visitorImage;
  final String visitorId;
  final String visitorSocCode;
  final String visitorTypeDetail;
  final String visitorType;
  final String visitorMobile;
  final String visitorFlatNo;
  VisitorFromNotification({
    required this.visitorName,
    required this.visitorImage,
    required this.visitorId,
    required this.visitorSocCode,
    required this.visitorTypeDetail,
    required this.visitorType,
    required this.visitorMobile,
    required this.visitorFlatNo,
  });

  VisitorFromNotification copyWith({
    String? visitorName,
    String? visitorImage,
    String? visitorId,
    String? visitorSocCode,
    String? visitorTypeDetail,
    String? visitorType,
    String? visitorMobile,
    String? visitorFlatNo,
  }) {
    return VisitorFromNotification(
      visitorName: visitorName ?? this.visitorName,
      visitorImage: visitorImage ?? this.visitorImage,
      visitorId: visitorId ?? this.visitorId,
      visitorSocCode: visitorSocCode ?? this.visitorSocCode,
      visitorTypeDetail: visitorTypeDetail ?? this.visitorTypeDetail,
      visitorType: visitorType ?? this.visitorType,
      visitorMobile: visitorMobile ?? this.visitorMobile,
      visitorFlatNo: visitorFlatNo ?? this.visitorFlatNo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'visitorName': visitorName,
      'visitorImage': visitorImage,
      'visitorId': visitorId,
      'visitorSocCode': visitorSocCode,
      'visitorTypeDetail': visitorTypeDetail,
      'visitorType': visitorType,
      'visitorMobile': visitorMobile,
      'visitorFlatNo': visitorFlatNo,
    };
  }

  factory VisitorFromNotification.fromMap(Map<String, dynamic> map) {
    return VisitorFromNotification(
      visitorName: map['name'] as String,
      visitorImage: map['image'] as String,
      visitorId: map['id'] as String,
      visitorSocCode: map['soc_code'] as String,
      visitorTypeDetail: map['visitor_type_detail'] as String,
      visitorType: map['visitor_type'] as String,
      visitorMobile: map['visitor_mobile'] as String,
      visitorFlatNo: map['visitor_flat_no'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VisitorFromNotification.fromJson(String source) =>
      VisitorFromNotification.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VisitorFromNotification(visitorName: $visitorName, visitorImage: $visitorImage, visitorId: $visitorId, visitorSocCode: $visitorSocCode, visitorTypeDetail: $visitorTypeDetail, visitorType: $visitorType, visitorMobile: $visitorMobile, visitorFlatNo: $visitorFlatNo)';
  }

  @override
  bool operator ==(covariant VisitorFromNotification other) {
    if (identical(this, other)) return true;

    return other.visitorName == visitorName &&
        other.visitorImage == visitorImage &&
        other.visitorId == visitorId &&
        other.visitorSocCode == visitorSocCode &&
        other.visitorTypeDetail == visitorTypeDetail &&
        other.visitorType == visitorType &&
        other.visitorMobile == visitorMobile &&
        other.visitorFlatNo == visitorFlatNo;
  }

  @override
  int get hashCode {
    return visitorName.hashCode ^
        visitorImage.hashCode ^
        visitorId.hashCode ^
        visitorSocCode.hashCode ^
        visitorTypeDetail.hashCode ^
        visitorType.hashCode ^
        visitorMobile.hashCode ^
        visitorFlatNo.hashCode;
  }
}
