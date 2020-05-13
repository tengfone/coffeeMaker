import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeemaker/models/brew.dart';
import 'package:coffeemaker/models/user.dart';

class DatabaseService {

  final String uid;

  DatabaseService({this.uid});

  // Collection Reference
  final CollectionReference brewCollection = Firestore.instance.collection(
      'brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // Convert snapshot to brew list
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
        // ?? handle error, if not return '' or 0 etc
          name: doc.data['name'] ?? '',
          strength: doc.data['strength'] ?? 0,
          sugars: doc.data['sugars'] ?? '0'
      );
    }).toList();
  }

  // get brew stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // userData from snapshot
  UserData _userDataFromSnapShot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  // get user doc stream
  Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapShot);
  }

}