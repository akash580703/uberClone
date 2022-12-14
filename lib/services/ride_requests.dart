import 'package:cloud_firestore/cloud_firestore.dart';
import '/helpers/constants.dart';

class RideRequestServices {
  String collection = "requests";

  void createRideRequest({
    String id,
    String userId,
    String username,
    Map<String, dynamic> destination,
    Map<String, dynamic> position,
    Map distance,
    String val,
  }) {
    firebaseFiretore.collection(collection).document(id).setData({
      "username": username,
      "id": id,
      "userId": userId,
      "driverId": "",
      "position": position,
      "status": 'pending',
      "destination": destination,
      "distance": distance,
      "key":val,
    });
  }

  void updateRequest(Map<String, dynamic> values) {
    firebaseFiretore
        .collection(collection)
        .document(values['id'])
        .updateData(values);
  }

  Stream<QuerySnapshot> requestStream() {
    CollectionReference reference = Firestore.instance.collection(collection);
    return reference.snapshots();
  }
}
