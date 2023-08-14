// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Resident {
  final String uid;
  final String socName;
  final String ownerTenant;
  final String ownerFirstName;
  final String ownerLastName;
  final String ownerImage;
  final String contactNumber;
  final String homeTownAddress;
  final String gender;
  final String profession;
  final String professionDetails;
  final String flatNumber;
  final String flatBlock;
  final String flatFloor;
  Resident({
    required this.uid,
    required this.socName,
    required this.ownerTenant,
    required this.ownerFirstName,
    required this.ownerLastName,
    required this.ownerImage,
    required this.contactNumber,
    required this.homeTownAddress,
    required this.gender,
    required this.profession,
    required this.professionDetails,
    required this.flatNumber,
    required this.flatBlock,
    required this.flatFloor,
  });

  Resident copyWith({
    String? uid,
    String? socName,
    String? ownerTenant,
    String? ownerFirstName,
    String? ownerLastName,
    String? ownerImage,
    String? contactNumber,
    String? homeTownAddress,
    String? gender,
    String? profession,
    String? professionDetails,
    String? flatNumber,
    String? flatBlock,
    String? flatFloor,
  }) {
    return Resident(
      uid: uid ?? this.uid,
      socName: socName ?? this.socName,
      ownerTenant: ownerTenant ?? this.ownerTenant,
      ownerFirstName: ownerFirstName ?? this.ownerFirstName,
      ownerLastName: ownerLastName ?? this.ownerLastName,
      ownerImage: ownerImage ?? this.ownerImage,
      contactNumber: contactNumber ?? this.contactNumber,
      homeTownAddress: homeTownAddress ?? this.homeTownAddress,
      gender: gender ?? this.gender,
      profession: profession ?? this.profession,
      professionDetails: professionDetails ?? this.professionDetails,
      flatNumber: flatNumber ?? this.flatNumber,
      flatBlock: flatBlock ?? this.flatBlock,
      flatFloor: flatFloor ?? this.flatFloor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'socName': socName,
      'ownerTenant': ownerTenant,
      'ownerFirstName': ownerFirstName,
      'ownerLastName': ownerLastName,
      'ownerImage': ownerImage,
      'contactNumber': contactNumber,
      'homeTownAddress': homeTownAddress,
      'gender': gender,
      'profession': profession,
      'professionDetails': professionDetails,
      'flatNumber': flatNumber,
      'flatBlock': flatBlock,
      'flatFloor': flatFloor,
    };
  }

  factory Resident.fromMap(Map<String, dynamic> map) {
    return Resident(
      uid: map['UID'] as String,
      socName: map['Soc_Name'] as String,
      ownerTenant: map['Owner_Tenant'] as String,
      ownerFirstName: map['Owner_First_Name'] as String,
      ownerLastName: map['Owner_Last_Name'] as String,
      ownerImage: map['Owner_Image'] as String,
      contactNumber: map['Contact_Number'] as String,
      homeTownAddress: map['Home_Town_Address'] as String,
      gender: map['Gender'] as String,
      profession: map['Profession'] as String,
      professionDetails: map['Profession_Details'] as String,
      flatNumber: map['Flat_Number'] as String,
      flatBlock: map['Flat_Block'] as String,
      flatFloor: map['Flat_Floor'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Resident.fromJson(String source) =>
      Resident.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Resident(uid: $uid, socName: $socName, ownerTenant: $ownerTenant, ownerFirstName: $ownerFirstName, ownerLastName: $ownerLastName, ownerImage: $ownerImage, contactNumber: $contactNumber, homeTownAddress: $homeTownAddress, gender: $gender, profession: $profession, professionDetails: $professionDetails, flatNumber: $flatNumber, flatBlock: $flatBlock, flatFloor: $flatFloor)';
  }

  @override
  bool operator ==(covariant Resident other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.socName == socName &&
        other.ownerTenant == ownerTenant &&
        other.ownerFirstName == ownerFirstName &&
        other.ownerLastName == ownerLastName &&
        other.ownerImage == ownerImage &&
        other.contactNumber == contactNumber &&
        other.homeTownAddress == homeTownAddress &&
        other.gender == gender &&
        other.profession == profession &&
        other.professionDetails == professionDetails &&
        other.flatNumber == flatNumber &&
        other.flatBlock == flatBlock &&
        other.flatFloor == flatFloor;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        socName.hashCode ^
        ownerTenant.hashCode ^
        ownerFirstName.hashCode ^
        ownerLastName.hashCode ^
        ownerImage.hashCode ^
        contactNumber.hashCode ^
        homeTownAddress.hashCode ^
        gender.hashCode ^
        profession.hashCode ^
        professionDetails.hashCode ^
        flatNumber.hashCode ^
        flatBlock.hashCode ^
        flatFloor.hashCode;
  }
}
