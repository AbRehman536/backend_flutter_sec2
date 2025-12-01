import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sec_2_backend/models/priority.dart';
import 'package:flutter_sec_2_backend/models/task.dart';

class PriorityServices {

  String PriorityCollection = "priorityCollection";

  //create Priority
  Future createPriority(PriorityTaskModel model) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection(PriorityCollection)
        .doc();
    return await FirebaseFirestore.instance
        .collection(PriorityCollection)
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }

  //update Priority
  Future updatePriority(PriorityTaskModel model) async {
    return await FirebaseFirestore.instance
        .collection(PriorityCollection)
        .doc(model.docId)
        .update({"name": model.name});
  }

  //delete Priority
  Future deleteTask(String priorityID) async {
    return await FirebaseFirestore.instance
        .collection(PriorityCollection)
        .doc(priorityID)
        .delete();
  }

  //get All Task
  Stream<List<PriorityTaskModel>> getAllPriority() {
    return FirebaseFirestore.instance
        .collection(PriorityCollection)
        .snapshots()
        .map((priorityList) =>
        priorityList.docs
            .map((taskJson) => PriorityTaskModel.fromJson(taskJson.data()))
            .toList()
    );
  }

  //get Priority
  Future<PriorityTaskModel> getPriority(){
    return FirebaseFirestore.instance
        .collection(PriorityCollection)
        .get()
        .then((taskList) => PriorityTaskModel.fromJson(taskList.data()!),
    );
  }

}

extension on QuerySnapshot<Map<String, dynamic>> {
  data() {}
}
