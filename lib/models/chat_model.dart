class ChatAppModel {
  String? id;
  String? message;
  String? senderName;
  String? senderId;
  String? receiverId;
  String? timestamp;

  ChatAppModel({
    this.id,
    this.message,
    this.senderName,
    this.senderId,
    this.receiverId,
    this.timestamp,
  });

  ChatAppModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["senderName"] is String) {
      senderName = json["senderName"];
    }
    if (json["senderId"] is String) {
      senderId = json["senderId"];
    }
    if (json["receiverId"] is String) {
      receiverId = json["receiverId"];
    }
    if (json["timestamp"] is String) {
      timestamp = json["timestamp"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["message"] = message;
    _data["senderName"] = senderName;
    _data["senderId"] = senderId;
    _data["receiverId"] = receiverId;
    _data["timestamp"] = timestamp;
    return _data;
  }
}
