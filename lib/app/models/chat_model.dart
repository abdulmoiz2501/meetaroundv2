class ChatModel {
  int? receiverId;
  List<Messages>? messages;
  UserDetails? userDetails;

  ChatModel({this.receiverId, this.messages, this.userDetails});

  ChatModel.fromJson(Map<String, dynamic> json) {
    receiverId = json['receiverId'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receiverId'] = this.receiverId;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.toJson();
    }
    return data;
  }
}

class Messages {
  int? senderId,receiverId;
  String? content;

  Messages({this.senderId, this.content});

  Messages.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['senderId'] = this.senderId;
    data['receiverId'] = this.receiverId;
    data['content'] = this.content;
    return data;
  }
}

class UserDetails {
  String? name;
  String? profilePicture;
  int? coins;

  UserDetails({this.name, this.profilePicture, this.coins});

  UserDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profilePicture = json['profilePicture'];
    coins = json['coins'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profilePicture'] = this.profilePicture;
    data['coins'] = this.coins;
    return data;
  }
}
