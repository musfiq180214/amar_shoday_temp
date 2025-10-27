class AddressModel {
  final int id;
  final String title;
  final String? details;

  AddressModel({
    required this.id,
    required this.title,
    this.details,
  });

  factory AddressModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AddressModel(id: 0, title: '', details: null);
    }
    return AddressModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      details: json['details'],
    );
  }
}

class RecipientModel {
  final String relation;
  final String name;
  final String phone;

  RecipientModel({
    required this.relation,
    required this.name,
    required this.phone,
  });

  factory RecipientModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return RecipientModel(relation: '', name: '', phone: '');
    }
    return RecipientModel(
      relation: json['relation'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}

class UserModel {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String? dob;
  final String? gender;
  final List<AddressModel> addresses;
  final RecipientModel? recipient;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.dob,
    this.gender,
    required this.addresses,
    this.recipient,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final addressRaw = json['addresses'];
    final recipientRaw = json['recipient'];

    List<AddressModel> addressList = [];
    if (addressRaw is List) {
      addressList = addressRaw.map((e) => AddressModel.fromJson(e)).toList();
    }

    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      dob: json['dob'],
      gender: json['gender'],
      addresses: addressList,
      recipient:
          recipientRaw != null ? RecipientModel.fromJson(recipientRaw) : null,
    );
  }
}
