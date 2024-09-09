import 'dart:io';

class Profile {
  final String image;
  final File? imageFile;
  final String fullname;
  final String location;
  final String locationLink;
  final String email;
  final String phoneNumber;
  final String lineId;
  final String lineLink;

  Profile({
    required this.image,
    this.imageFile,
    required this.fullname,
    required this.location,
    required this.locationLink,
    required this.email,
    required this.phoneNumber,
    required this.lineId,
    required this.lineLink,
  });

// make init profile to data above
  factory Profile.init() {
    return Profile(
      fullname: 'Sukanya Yamnarm',
      image: 'assets/images/profile/avatar_default.png',
      email: 'snow_lechers@hotmail.com',
      phoneNumber: '0909108540',
      lineId: 'alex_calcium',
      lineLink: 'https://line.me/ti/p/~alex_calcium',
      location: 'centralwOrld',
      locationLink: 'https://www.google.com/maps/search/?api=1&query=centralwOrld',
    );
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      image: map['image'],
      imageFile: map['imageFile'],
      fullname: map['fullname'],
      location: map['location'],
      locationLink: map['locationLink'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      lineId: map['lineId'],
      lineLink: 'https://line.me/ti/p/${map['lineId']}',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'imageFile': imageFile,
      'fullname': fullname,
      'location': location,
      'locationLink': locationLink,
      'email': email,
      'phoneNumber': phoneNumber,
      'lineId': lineId,
      'lineLink': lineLink,
    };
  }

  Profile copyWith({
    String? image,
    File? imageFile,
    String? fullname,
    String? location,
    String? locationLink,
    String? email,
    String? phoneNumber,
    String? lineId,
    String? lineLink,
  }) {
    return Profile(
      image: image ?? this.image,
      imageFile: imageFile ?? this.imageFile,
      fullname: fullname ?? this.fullname,
      location: location ?? this.location,
      locationLink: locationLink ?? this.locationLink,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      lineId: lineId ?? this.lineId,
      lineLink: lineLink ?? this.lineLink,
    );
  }
}
