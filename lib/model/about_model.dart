class AboutUsModel {
  final int id;
  final String aboutPhoneNo1;
  final String? aboutPhoneNo2;
  final String address;
  final String openingHours;
  final String aboutImage1;
  final String aboutImage2;

  AboutUsModel({
    required this.id,
    required this.aboutPhoneNo1,
    this.aboutPhoneNo2,
    required this.address,
    required this.openingHours,
    required this.aboutImage1,
    required this.aboutImage2,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
    id: json['id'] is int
        ? json['id']
        : int.tryParse(json['id'].toString()) ?? 0,
    aboutPhoneNo1: json['about_phone_no_1']?.toString() ?? '',
    aboutPhoneNo2: json['about_phone_no_2']?.toString(),
    address: json['address']?.toString() ?? '',
    openingHours: json['opening_hours']?.toString() ?? '',
    aboutImage1: json['about_image_1']?.toString() ?? '',
    aboutImage2: json['about_image_2']?.toString() ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'about_phone_no_1': aboutPhoneNo1,
    if (aboutPhoneNo2 != null) 'about_phone_no_2': aboutPhoneNo2,
    'address': address,
    'opening_hours': openingHours,
    'about_image_1': aboutImage1,
    'about_image_2': aboutImage2,
  };
}
