// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Visitor {
  final String visitorId;
  final String socCode;
  final String visitorType;
  final String visitorTypeDetail;
  final String visitorName;
  final String visitorMobile;
  final String visitorFlatNo;
  final String visitorImage;
  final String visitorEnterDate;
  final String visitorEnterTime;
  final String? visitorExitDate;
  final String? visitorExitTime;
  final String visitorApproveBy;
  final String visitorStatus;
  final String visitorIsValid;
  Visitor({
    required this.visitorId,
    required this.socCode,
    required this.visitorType,
    required this.visitorTypeDetail,
    required this.visitorName,
    required this.visitorMobile,
    required this.visitorFlatNo,
    required this.visitorImage,
    required this.visitorEnterDate,
    required this.visitorEnterTime,
    required this.visitorExitDate,
    required this.visitorExitTime,
    required this.visitorApproveBy,
    required this.visitorStatus,
    required this.visitorIsValid,
  });

  Visitor copyWith({
    String? visitorId,
    String? socCode,
    String? visitorType,
    String? visitorTypeDetail,
    String? visitorName,
    String? visitorMobile,
    String? visitorFlatNo,
    String? visitorImage,
    String? visitorEnterDate,
    String? visitorEnterTime,
    String? visitorExitDate,
    String? visitorExitTime,
    String? visitorApproveBy,
    String? visitorStatus,
    String? visitorIsValid,
  }) {
    return Visitor(
      visitorId: visitorId ?? this.visitorId,
      socCode: socCode ?? this.socCode,
      visitorType: visitorType ?? this.visitorType,
      visitorTypeDetail: visitorTypeDetail ?? this.visitorTypeDetail,
      visitorName: visitorName ?? this.visitorName,
      visitorMobile: visitorMobile ?? this.visitorMobile,
      visitorFlatNo: visitorFlatNo ?? this.visitorFlatNo,
      visitorImage: visitorImage ?? this.visitorImage,
      visitorEnterDate: visitorEnterDate ?? this.visitorEnterDate,
      visitorEnterTime: visitorEnterTime ?? this.visitorEnterTime,
      visitorExitDate: visitorExitDate ?? this.visitorExitDate,
      visitorExitTime: visitorExitTime ?? this.visitorExitTime,
      visitorApproveBy: visitorApproveBy ?? this.visitorApproveBy,
      visitorStatus: visitorStatus ?? this.visitorStatus,
      visitorIsValid: visitorIsValid ?? this.visitorIsValid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'visitorId': visitorId,
      'socCode': socCode,
      'visitorType': visitorType,
      'visitorTypeDetail': visitorTypeDetail,
      'visitorName': visitorName,
      'visitorMobile': visitorMobile,
      'visitorFlatNo': visitorFlatNo,
      'visitorImage': visitorImage,
      'visitorEnterDate': visitorEnterDate,
      'visitorEnterTime': visitorEnterTime,
      'visitorExitDate': visitorExitDate,
      'visitorExitTime': visitorExitTime,
      'visitorApproveBy': visitorApproveBy,
      'visitorStatus': visitorStatus,
      'visitorIsValid': visitorIsValid,
    };
  }

  factory Visitor.fromMap(Map<String, dynamic> map) {
    return Visitor(
      visitorId: map['visitor_id'] as String,
      socCode: map['soc_code'] as String,
      visitorType: map['visitor_type'] as String,
      visitorTypeDetail: map['visitor_type_detail'] as String,
      visitorName: map['visitor_name'] as String,
      visitorMobile: map['visitor_mobile'] as String,
      visitorFlatNo: map['visitor_flat_no'] as String,
      visitorImage: map['visitor_image'] as String,
      visitorEnterDate: map['visitor_enter_date'] as String,
      visitorEnterTime: map['visitor_enter_time'] as String,
      visitorExitDate: map['visitor_exit_date'] != null
          ? map['visitor_exit_date'] as String
          : "",
      visitorExitTime: map['visitor_exit_time'] != null
          ? map['visitor_exit_time'] as String
          : "",
      visitorApproveBy: map['visitor_approve_by'] as String,
      visitorStatus: map['visitor_status'] as String,
      visitorIsValid: map['visitor_is_valid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Visitor.fromJson(String source) =>
      Visitor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Visitor(visitorId: $visitorId, socCode: $socCode, visitorType: $visitorType, visitorTypeDetail: $visitorTypeDetail, visitorName: $visitorName, visitorMobile: $visitorMobile, visitorFlatNo: $visitorFlatNo, visitorImage: $visitorImage, visitorEnterDate: $visitorEnterDate, visitorEnterTime: $visitorEnterTime, visitorExitDate: $visitorExitDate, visitorExitTime: $visitorExitTime, visitorApproveBy: $visitorApproveBy, visitorStatus: $visitorStatus, visitorIsValid: $visitorIsValid)';
  }

  @override
  bool operator ==(covariant Visitor other) {
    if (identical(this, other)) return true;

    return other.visitorId == visitorId &&
        other.socCode == socCode &&
        other.visitorType == visitorType &&
        other.visitorTypeDetail == visitorTypeDetail &&
        other.visitorName == visitorName &&
        other.visitorMobile == visitorMobile &&
        other.visitorFlatNo == visitorFlatNo &&
        other.visitorImage == visitorImage &&
        other.visitorEnterDate == visitorEnterDate &&
        other.visitorEnterTime == visitorEnterTime &&
        other.visitorExitDate == visitorExitDate &&
        other.visitorExitTime == visitorExitTime &&
        other.visitorApproveBy == visitorApproveBy &&
        other.visitorStatus == visitorStatus &&
        other.visitorIsValid == visitorIsValid;
  }

  @override
  int get hashCode {
    return visitorId.hashCode ^
        socCode.hashCode ^
        visitorType.hashCode ^
        visitorTypeDetail.hashCode ^
        visitorName.hashCode ^
        visitorMobile.hashCode ^
        visitorFlatNo.hashCode ^
        visitorImage.hashCode ^
        visitorEnterDate.hashCode ^
        visitorEnterTime.hashCode ^
        visitorExitDate.hashCode ^
        visitorExitTime.hashCode ^
        visitorApproveBy.hashCode ^
        visitorStatus.hashCode ^
        visitorIsValid.hashCode;
  }
}
