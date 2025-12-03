import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sec_2_backend/models/task.dart';

class TaskServices{

  String TaskCollection = "taskCollection";
  //create Task
  Future createTask(TaskModel model)async{
    DocumentReference documentReference = FirebaseFirestore.instance
    .collection(TaskCollection)
    .doc();
    return await FirebaseFirestore.instance
        .collection(TaskCollection)
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }
  //update Task
  Future updateTask(TaskModel model)async{
    return await FirebaseFirestore.instance
        .collection(TaskCollection)
        .doc(model.docId)
        .update({"name":model.name, "description": model.description});
  }
  //delete Task
  Future deleteTask(String taskID)async{
    return await FirebaseFirestore.instance
        .collection(TaskCollection)
        .doc(taskID)
        .delete();
  }
  //mark As Completed
  Future markAsCompleted({
    required String taskID,
    required bool isCompleted})async{
    return await FirebaseFirestore.instance
        .collection(TaskCollection)
        .doc(taskID)
        .update({"isCompleted" : isCompleted});

  }
  //get All Task
  Stream<List<TaskModel>> getAllTask(){
    return FirebaseFirestore.instance
        .collection(TaskCollection)
        .snapshots()
        .map((taskList)=>taskList.docs
        .map((taskJson)=>TaskModel.fromJson(taskJson.data()))
        .toList()
    );
  }
  //get Incompleted Task
  Stream<List<TaskModel>> getInCompletedTask(){
    return FirebaseFirestore.instance
        .collection(TaskCollection)
        .where("isCompleted", isEqualTo: false)
        .snapshots()
        .map((taskList)=> taskList.docs
        .map((taskJson)=>TaskModel.fromJson(taskJson.data()))
        .toList()
    );
  }
  //get Completed Task
  Stream<List<TaskModel>> getCompletedTask(){
    return FirebaseFirestore.instance
        .collection(TaskCollection)
        .where("isCompleted", isEqualTo:true)
        .snapshots()
        .map((taskList)=> taskList.docs
        .map((taskJson)=>TaskModel.fromJson(taskJson.data()))
        .toList()
    );
  }
  //Get Favorite Task
  Stream<List<TaskModel>> getFavorite(String userID){
    return FirebaseFirestore.instance
        .collection(TaskCollection)
        .where('favorite', arrayContains: userID)
        .snapshots()
        .map((taskList)=>taskList.docs
        .map((taskJson)=>TaskModel.fromJson(taskJson.data())).toList()
    );
  }

  //add to favorite
  Future addToFavorite({required String userID, required String taskID})async{
    return await FirebaseFirestore.instance
        .collection(TaskCollection)
        .doc(taskID)
        .update({'favorite' : FieldValue.arrayUnion([userID])});
  }
  //remove from favorite
  Future removeFromFavorite({required String userID, required String taskID})async{
    return await FirebaseFirestore.instance
        .collection(TaskCollection)
        .doc(taskID)
        .update({'favorite' : FieldValue.arrayRemove([userID])});
  }
}