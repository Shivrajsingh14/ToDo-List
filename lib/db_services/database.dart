import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  Future addPersonalTask(
      Map<String, dynamic> userPersonalMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Personal")
        .doc(id)
        .set(userPersonalMap);
  }

  Future addcollegeTask(Map<String, dynamic> userPersonalMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("college")
        .doc(id)
        .set(userPersonalMap);
  }

  Future addofficeTask(Map<String, dynamic> userPersonalMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("office")
        .doc(id)
        .set(userPersonalMap);
  }

  Future<Stream<QuerySnapshot>> getTask(String task) async {
    return await FirebaseFirestore.instance.collection(task).snapshots();
  }

  tickMethod(String id, String task) async {
    return await FirebaseFirestore.instance
        .collection(task)
        .doc(id)
        .update({"Yes": true});
  }

  removeMethod(String id, String task) async {
    return await FirebaseFirestore.instance.collection(task).doc(id).delete();
  }
}
