// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String uid;
  final String ownerTenant;
  final String ownerName;
  final String ownerImage;
  final String contactNumber;
  final String email;
  final String password;
  final String hometownAddress;
  final String member;
  final String gender;
  final String dob;
  final String bloodGroup;
  final String profession;
  final String professionDetails;
  final String flatNumber;
  final String flatBlock;
  final String flatFloor;
  final String flatType;
  final String parkingType;
  final String parkingNumber;
  final String petType;
  final String petName;
  final String twoWheelerType;
  final String twoWheelerNumber;
  final String fourWheelerBrand;
  final String fourWheelerNumber;
  final String creationDate;
  final String isActive;
  User({
    required this.uid,
    required this.ownerTenant,
    required this.ownerName,
    required this.ownerImage,
    required this.contactNumber,
    required this.email,
    required this.password,
    required this.hometownAddress,
    required this.member,
    required this.gender,
    required this.dob,
    required this.bloodGroup,
    required this.profession,
    required this.professionDetails,
    required this.flatNumber,
    required this.flatBlock,
    required this.flatFloor,
    required this.flatType,
    required this.parkingType,
    required this.parkingNumber,
    required this.petType,
    required this.petName,
    required this.twoWheelerType,
    required this.twoWheelerNumber,
    required this.fourWheelerBrand,
    required this.fourWheelerNumber,
    required this.creationDate,
    required this.isActive,
  });

  User copyWith({
    String? uid,
    String? ownerTenant,
    String? ownerName,
    String? ownerImage,
    String? contactNumber,
    String? email,
    String? password,
    String? hometownAddress,
    String? member,
    String? gender,
    String? dob,
    String? bloodGroup,
    String? profession,
    String? professionDetails,
    String? flatNumber,
    String? flatBlock,
    String? flatFloor,
    String? flatType,
    String? parkingType,
    String? parkingNumber,
    String? petType,
    String? petName,
    String? twoWheelerType,
    String? twoWheelerNumber,
    String? fourWheelerBrand,
    String? fourWheelerNumber,
    String? creationDate,
    String? isActive,
  }) {
    return User(
      uid: uid ?? this.uid,
      ownerTenant: ownerTenant ?? this.ownerTenant,
      ownerName: ownerName ?? this.ownerName,
      ownerImage: ownerImage ?? this.ownerImage,
      contactNumber: contactNumber ?? this.contactNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      hometownAddress: hometownAddress ?? this.hometownAddress,
      member: member ?? this.member,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      profession: profession ?? this.profession,
      professionDetails: professionDetails ?? this.professionDetails,
      flatNumber: flatNumber ?? this.flatNumber,
      flatBlock: flatBlock ?? this.flatBlock,
      flatFloor: flatFloor ?? this.flatFloor,
      flatType: flatType ?? this.flatType,
      parkingType: parkingType ?? this.parkingType,
      parkingNumber: parkingNumber ?? this.parkingNumber,
      petType: petType ?? this.petType,
      petName: petName ?? this.petName,
      twoWheelerType: twoWheelerType ?? this.twoWheelerType,
      twoWheelerNumber: twoWheelerNumber ?? this.twoWheelerNumber,
      fourWheelerBrand: fourWheelerBrand ?? this.fourWheelerBrand,
      fourWheelerNumber: fourWheelerNumber ?? this.fourWheelerNumber,
      creationDate: creationDate ?? this.creationDate,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'ownerTenant': ownerTenant,
      'ownerName': ownerName,
      'ownerImage': ownerImage,
      'contactNumber': contactNumber,
      'email': email,
      'password': password,
      'hometownAddress': hometownAddress,
      'member': member,
      'gender': gender,
      'dob': dob,
      'bloodGroup': bloodGroup,
      'profession': profession,
      'professionDetails': professionDetails,
      'flatNumber': flatNumber,
      'flatBlock': flatBlock,
      'flatFloor': flatFloor,
      'flatType': flatType,
      'parkingType': parkingType,
      'parkingNumber': parkingNumber,
      'petType': petType,
      'petName': petName,
      'twoWheelerType': twoWheelerType,
      'twoWheelerNumber': twoWheelerNumber,
      'fourWheelerBrand': fourWheelerBrand,
      'fourWheelerNumber': fourWheelerNumber,
      'creationDate': creationDate,
      'isActive': isActive,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] as String,
      ownerTenant: map['Owner_Tenant'] as String,
      ownerName: map['ownerName'] as String,
      ownerImage: map['ownerImage'] as String,
      contactNumber: map['contactNumber'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      hometownAddress: map['hometownAddress'] as String,
      member: map['member'] as String,
      gender: map['gender'] as String,
      dob: map['dob'] as String,
      bloodGroup: map['bloodGroup'] as String,
      profession: map['profession'] as String,
      professionDetails: map['professionDetails'] as String,
      flatNumber: map['flatNumber'] as String,
      flatBlock: map['flatBlock'] as String,
      flatFloor: map['flatFloor'] as String,
      flatType: map['flatType'] as String,
      parkingType: map['parkingType'] as String,
      parkingNumber: map['parkingNumber'] as String,
      petType: map['petType'] as String,
      petName: map['petName'] as String,
      twoWheelerType: map['twoWheelerType'] as String,
      twoWheelerNumber: map['twoWheelerNumber'] as String,
      fourWheelerBrand: map['fourWheelerBrand'] as String,
      fourWheelerNumber: map['fourWheelerNumber'] as String,
      creationDate: map['creationDate'] as String,
      isActive: map['isActive'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(uid: $uid, ownerTenant: $ownerTenant, ownerName: $ownerName, ownerImage: $ownerImage, contactNumber: $contactNumber, email: $email, password: $password, hometownAddress: $hometownAddress, member: $member, gender: $gender, dob: $dob, bloodGroup: $bloodGroup, profession: $profession, professionDetails: $professionDetails, flatNumber: $flatNumber, flatBlock: $flatBlock, flatFloor: $flatFloor, flatType: $flatType, parkingType: $parkingType, parkingNumber: $parkingNumber, petType: $petType, petName: $petName, twoWheelerType: $twoWheelerType, twoWheelerNumber: $twoWheelerNumber, fourWheelerBrand: $fourWheelerBrand, fourWheelerNumber: $fourWheelerNumber, creationDate: $creationDate, isActive: $isActive)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.ownerTenant == ownerTenant &&
        other.ownerName == ownerName &&
        other.ownerImage == ownerImage &&
        other.contactNumber == contactNumber &&
        other.email == email &&
        other.password == password &&
        other.hometownAddress == hometownAddress &&
        other.member == member &&
        other.gender == gender &&
        other.dob == dob &&
        other.bloodGroup == bloodGroup &&
        other.profession == profession &&
        other.professionDetails == professionDetails &&
        other.flatNumber == flatNumber &&
        other.flatBlock == flatBlock &&
        other.flatFloor == flatFloor &&
        other.flatType == flatType &&
        other.parkingType == parkingType &&
        other.parkingNumber == parkingNumber &&
        other.petType == petType &&
        other.petName == petName &&
        other.twoWheelerType == twoWheelerType &&
        other.twoWheelerNumber == twoWheelerNumber &&
        other.fourWheelerBrand == fourWheelerBrand &&
        other.fourWheelerNumber == fourWheelerNumber &&
        other.creationDate == creationDate &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        ownerTenant.hashCode ^
        ownerName.hashCode ^
        ownerImage.hashCode ^
        contactNumber.hashCode ^
        email.hashCode ^
        password.hashCode ^
        hometownAddress.hashCode ^
        member.hashCode ^
        gender.hashCode ^
        dob.hashCode ^
        bloodGroup.hashCode ^
        profession.hashCode ^
        professionDetails.hashCode ^
        flatNumber.hashCode ^
        flatBlock.hashCode ^
        flatFloor.hashCode ^
        flatType.hashCode ^
        parkingType.hashCode ^
        parkingNumber.hashCode ^
        petType.hashCode ^
        petName.hashCode ^
        twoWheelerType.hashCode ^
        twoWheelerNumber.hashCode ^
        fourWheelerBrand.hashCode ^
        fourWheelerNumber.hashCode ^
        creationDate.hashCode ^
        isActive.hashCode;
  }
}
