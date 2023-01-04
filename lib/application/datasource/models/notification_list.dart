/// items : [{"id":1,"userId":18,"subject":"bnk_notification","content":"Quý khách đã tạo thành công tài khoản 0123456780","status":false,"type":1,"createdAt":"2023-01-03T03:57:07.008+00:00","updatedAt":"2023-01-03T03:57:07.008+00:00"}]
/// totalItems : 1

class NotificationList {
  NotificationList({
    List<NotificationItem>? items,
    int? totalItems,}){
    _items = items;
    _totalItems = totalItems;
  }

  NotificationList.fromJson(dynamic json) {
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(NotificationItem.fromJson(v));
      });
    }
    _totalItems = json['totalItems'];
  }
  List<NotificationItem>? _items;
  int? _totalItems;
  NotificationList copyWith({  List<NotificationItem>? items,
    int? totalItems,
  }) => NotificationList(  items: items ?? _items,
    totalItems: totalItems ?? _totalItems,
  );
  List<NotificationItem>? get items => _items;
  int? get totalItems => _totalItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    map['totalItems'] = _totalItems;
    return map;
  }

}

/// id : 1
/// userId : 18
/// subject : "bnk_notification"
/// content : "Quý khách đã tạo thành công tài khoản 0123456780"
/// status : false
/// type : 1
/// createdAt : "2023-01-03T03:57:07.008+00:00"
/// updatedAt : "2023-01-03T03:57:07.008+00:00"

class NotificationItem {
  NotificationItem({
    int? id,
    int? userId,
    String? subject,
    String? content,
    bool? status,
    int? type,
    String? createdAt,
    String? updatedAt,}){
    _id = id;
    _userId = userId;
    _subject = subject;
    _content = content;
    _status = status;
    _type = type;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  NotificationItem.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _subject = json['subject'];
    _content = json['content'];
    _status = json['status'];
    _type = json['type'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  int? _id;
  int? _userId;
  String? _subject;
  String? _content;
  bool? _status;
  int? _type;
  String? _createdAt;
  String? _updatedAt;
  NotificationItem copyWith({  int? id,
    int? userId,
    String? subject,
    String? content,
    bool? status,
    int? type,
    String? createdAt,
    String? updatedAt,
  }) => NotificationItem(  id: id ?? _id,
    userId: userId ?? _userId,
    subject: subject ?? _subject,
    content: content ?? _content,
    status: status ?? _status,
    type: type ?? _type,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
  );
  int? get id => _id;
  int? get userId => _userId;
  String? get subject => _subject;
  String? get content => _content;
  bool get status => _status ?? false;
  int? get type => _type;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['subject'] = _subject;
    map['content'] = _content;
    map['status'] = _status;
    map['type'] = _type;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}