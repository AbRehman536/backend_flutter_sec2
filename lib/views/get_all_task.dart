import 'package:flutter/material.dart';
import 'package:flutter_sec_2_backend/models/task.dart';
import 'package:flutter_sec_2_backend/services/task.dart';
import 'package:flutter_sec_2_backend/views/create_task.dart';
import 'package:flutter_sec_2_backend/views/get_completed_task.dart';
import 'package:flutter_sec_2_backend/views/get_incompleted_task.dart';
import 'package:flutter_sec_2_backend/views/get_priority.dart';
import 'package:flutter_sec_2_backend/views/update_task.dart';
import 'package:provider/provider.dart';

class GetAllTask extends StatelessWidget {
  const GetAllTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetCompletedTask()));
          }, icon: Icon(Icons.task_alt)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetInCompletedTask()));
          }, icon: Icon(Icons.incomplete_circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetPriority()));
          }, icon: Icon(Icons.category)),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateTask()));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
          value: TaskServices().getAllTask(),
          initialData: [TaskModel()],
        builder: (context, child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.task),
                  title: Text(taskList[index].name.toString()),
                  subtitle: Text(taskList[index].description.toString()),
                  trailing:
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: taskList[index].isCompleted,
                        onChanged: (bool? value) async{ 
                          try{
                            await TaskServices().markAsCompleted( taskID:
                                taskList[index].docId.toString(), isCompleted: value!);
                          }catch(e){
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(e.toString())));
                          }
                        }, ),
                      IconButton(onPressed: ()async{
                        try{
                          await TaskServices().deleteTask(taskList[index].docId.toString());
                        }catch(e){
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      }, icon: Icon(Icons.delete)),
                      IconButton(onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context)=>UpdateTask(model: taskList[index])));
                      }, icon: Icon(Icons.edit)),
                    ],
                  ),
                );
              },);
        },

      )
    );
  }
}
