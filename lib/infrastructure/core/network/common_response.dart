import 'package:flutter/foundation.dart';

class CommonResponse<T> {
  bool? status;
  String? dioMessage;
  T? data;
  List<T>? listData;
  Errors? errors;
  Meta? meta;

  CommonResponse({
    this.status,
    this.dioMessage,
    this.data,
    this.listData,
    this.errors,
    this.meta,
  });

  CommonResponse.fromJson(Map<String, dynamic> json) {
    status = json['success'];
    dioMessage = json['message'];

    data = json['data'];

    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    if (json.containsKey("meta") && json["meta"] != null) {
      meta = Meta.fromJson(json['meta']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = status;
    data['message'] = dioMessage;
    data['data'] = data;
    data['errors'] = errors;
    try {
      if (errors != null) {
        data['errors'] = errors?.toJson();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    if (meta != null) {
      data['meta'] = meta?.toJson();
    }
    return data;
  }
}

// class CommonErrors {
//   String message;
//   Errors errors;
//
//   CommonErrors({this.message, this.errors});
//
//   CommonErrors.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     errors = json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     if (this.errors != null) {
//       data['errors'] = this.errors.toJson();
//     }
//     return data;
//   }
// }

class Errors {
  List<String>? firstName;
  List<String>? lastName;
  List<String>? email;
  List<String>? birthDate;
  List<String>? lookingFor;
  List<String>? gender;
  List<String>? lookingGender;
  List<String>? deviceToken;
  List<String>? qrCode;
  List<String>? referralByUser;

  Errors(
      {this.firstName,
      this.lastName,
      this.email,
      this.birthDate,
      this.lookingFor,
      this.gender,
      this.lookingGender});

  Errors.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name']?.cast<String>();
    lastName = json['last_name']?.cast<String>();
    email = json['email']?.cast<String>();
    birthDate = json['birth_date']?.cast<String>();
    lookingFor = json['looking_for']?.cast<String>();
    gender = json['gender']?.cast<String>();
    lookingGender = json['looking_gender']?.cast<String>();
    qrCode = json['qr_code']?.cast<String>();
    referralByUser = json['referral_by_user']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['birth_date'] = birthDate;
    data['looking_for'] = lookingFor;
    data['gender'] = gender;
    data['looking_gender'] = lookingGender;
    data['qr_code'] = qrCode;
    data['referral_by_user'] = referralByUser;
    return data;
  }
}

class ErrorResponse {
  String? status;
  Message? message;

  ErrorResponse({this.status, this.message});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (message != null) {
      data['message'] = message?.toJson();
    }
    return data;
  }
}

class Message {
  List<Details>? details;

  Message({this.details});

  Message.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details?.add(Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (details != null) {
      data['details'] = details?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? message;
  List<String>? path;
  String? type;

  Details({this.message, this.path, this.type});

  Details.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    path = json['path'].cast<String>();
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['path'] = path;
    data['type'] = type;
    return data;
  }
}

class ErrorSimpleResponse {
  String? status;
  String? message;

  ErrorSimpleResponse({this.status, this.message});

  ErrorSimpleResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class Meta {
  int? total;
  int? lastPage;
  int? perPage;
  int? currentPage;
  int? from;
  int? to;

  Meta(
      {this.total,
      this.lastPage,
      this.perPage,
      this.currentPage,
      this.from,
      this.to});

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    lastPage = json['last_page'];
    perPage = json['perPage'];
    currentPage = json['currentPage'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['lastPage'] = lastPage;
    data['perPage'] = perPage;
    data['currentPage'] = currentPage;
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}
