import 'package:flutter/material.dart';
import 'package:flutter_sec_2_backend/models/priority.dart';
import 'package:flutter_sec_2_backend/models/task.dart';
import 'package:flutter_sec_2_backend/services/priority.dart';
import 'package:flutter_sec_2_backend/services/task.dart';
import 'package:flutter_sec_2_backend/views/create_priority.dart';
import 'package:provider/provider.dart';

class GetPriorityID extends StatelessWidget {
  final PriorityModel model;
  const GetPriorityID({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Priority"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreatePriority(model: PriorityModel(), isUpdateMode: false)));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
        value: TaskServices().getTaskByPriorityID(
            model.docId.toString()),
        initialData: [TaskModel()],
        builder: (context, child){
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskList[index].name.toString()),
              );
            },);
        },
      ),
    );
  }
}
