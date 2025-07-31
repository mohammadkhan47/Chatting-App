import 'package:chattingapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firstore = FirebaseFirestore.instance;
Future<void> createUser(UserModel user) async{
  try{
    await _firstore.collection('users').doc(user.id).set(user.toMap());
  }catch(e){
    throw Exception('failed to create user: ${e.toString()}');
  }
}
Future<UserModel?> getUser(String userid) async{
  try{
    DocumentSnapshot doc = await _firstore.collection('users').doc(userid).get();
    if(doc.exists){
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }catch(e){
    throw Exception('failed to get user: ${e.toString()}');
   }
 }
Future<void> updateUserOnlineStatus(String userid, bool isOnline) async{
  try{
    DocumentSnapshot doc = await _firstore.collection('users').doc(userid).get();
    if(doc.exists){
      await _firstore.collection('users').doc(userid).update({
        'isOnline': isOnline,
        'lastSeen': DateTime.now().millisecondsSinceEpoch,
      });
    }
  }catch(e){
    throw Exception('failed to update user online status');
  }
}
Future<void> deleteUser(String userid) async{
  try{
    await _firstore.collection('users').doc(userid).delete();
  }catch(e){
    throw Exception('failed to delete user: ${e.toString()}');
  }
}
 Stream<UserModel?> getUserStream(String userid){
  return _firstore.collection('users').doc(userid).snapshots().map((doc) =>doc.exists ? UserModel.fromMap(doc.data()!): null);
 }
 Future<void> updateUser(UserModel user) async {
  try{
    await _firstore.collection('users').doc(user.id).update(user.toMap());
  }catch(e){
    throw Exception('failed to update');
  }
 }
}