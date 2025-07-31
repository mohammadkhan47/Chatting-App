import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String displayName;
  final String photoUrl;
  final bool isOnline;
  final DateTime lastSeen;
  final DateTime createAt;

  UserModel({
   required this.id,
   required this.email,
   required this.displayName,
    this.photoUrl = "",
    this.isOnline= false,
   required this.lastSeen,
   required this.createAt,
});
  Map<String , dynamic> toMap(){
    return {
      'id' : id,
      'email' : email,
      'displayName' : displayName,
      'photoUrl': photoUrl,
      'isOnline' : isOnline,
      'lastSeen' : lastSeen,
      'createAt' : createAt,
    };
  }
  static UserModel fromMap(Map<String, dynamic> map){
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      isOnline: map['isOnline'] ?? false,
      lastSeen: map['lastSeen'] != null ? (map['lastSeen']as Timestamp).toDate()
          : DateTime.now(),
      createAt: DateTime.fromMillisecondsSinceEpoch(map['createAt'] ?? 0),

    );
  }
  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    bool? isOnline,
    DateTime? lastSeen,
    DateTime? createAt,
  }){
    return UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        displayName: displayName ?? this.displayName,
        photoUrl: photoUrl ?? this.photoUrl,
        isOnline: isOnline ?? this.isOnline,
        lastSeen: lastSeen ?? this.lastSeen,
        createAt: createAt ?? this.createAt);
  }
}