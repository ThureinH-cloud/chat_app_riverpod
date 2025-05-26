class MessageModel {
  MessageModel({
    this.status,
    this.message,
    this.data,
  });

  MessageModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? status;
  String? message;
  List<Data>? data;
  MessageModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      MessageModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.sender,
    this.content,
    this.type,
    this.chat,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Data.fromJson(dynamic json) {
    id = json['_id'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    content = json['content'];
    type = json['type'];
    chat = json['chat'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  Sender? sender;
  String? content;
  String? type;
  dynamic chat;
  String? createdAt;
  String? updatedAt;
  num? v;
  Data copyWith({
    String? id,
    Sender? sender,
    String? content,
    String? type,
    dynamic chat,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      Data(
        id: id ?? this.id,
        sender: sender ?? this.sender,
        content: content ?? this.content,
        type: type ?? this.type,
        chat: chat ?? this.chat,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (sender != null) {
      map['sender'] = sender?.toJson();
    }
    map['content'] = content;
    map['type'] = type;
    map['chat'] = chat;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}

class Sender {
  Sender({
    this.id,
    this.name,
    this.cover,
    this.email,
    this.isVerified,
    this.isBanned,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Sender.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    cover = json['cover'];
    email = json['email'];
    isVerified = json['is_verified'];
    isBanned = json['is_banned'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? name;
  dynamic cover;
  String? email;
  bool? isVerified;
  bool? isBanned;
  String? createdAt;
  String? updatedAt;
  num? v;
  Sender copyWith({
    String? id,
    String? name,
    dynamic cover,
    String? email,
    bool? isVerified,
    bool? isBanned,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      Sender(
        id: id ?? this.id,
        name: name ?? this.name,
        cover: cover ?? this.cover,
        email: email ?? this.email,
        isVerified: isVerified ?? this.isVerified,
        isBanned: isBanned ?? this.isBanned,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['cover'] = cover;
    map['email'] = email;
    map['is_verified'] = isVerified;
    map['is_banned'] = isBanned;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}
