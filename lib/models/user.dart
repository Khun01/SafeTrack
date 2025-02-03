class User {
  final int id;
  final String name;
  final String email;
  final String? gender;
  final String? phoneNumber;
  final String? address;
  final String? dateOfBirth;
  final String? emergencyContactName;
  final String? emergencyContactNumber;
  final String? relationship;
  final int isVerified;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.gender,
    this.phoneNumber,
    this.address,
    this.dateOfBirth,
    this.emergencyContactName,
    this.emergencyContactNumber,
    this.relationship,
    required this.isVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'] ?? 'Gender',
      phoneNumber: json['phone_number'] ?? 'Your contact number',
      address: json['address'] ?? 'Your address',
      dateOfBirth: json['date_of_birth'] ?? 'Your birthday',
      emergencyContactName: json['emergency_contact_name'] ?? 'Your emergecny contact person',
      emergencyContactNumber: json['emergency_contact_number'] ?? 'Your emergency contact number',
      relationship: json['relationship'] ?? 'Youy relationship to your emergency contact person',
      isVerified: json['isVerified'],
    );
  }
}
