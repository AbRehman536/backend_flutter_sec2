import 'package:flutter/material.dart';
import 'package:flutter_sec_2_backend/models/priority.dart';
import 'package:flutter_sec_2_backend/models/task.dart';
import 'package:flutter_sec_2_backend/services/priority.dart';
import 'package:flutter_sec_2_backend/services/task.dart';

class CreateTask extends StatefulWidget {

  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;

  List<PriorityModel> priorityList = [];
  PriorityModel? _selectedPriority;
  @override
  void initState(){
    PriorityServices().getPriorities().then((val){
      priorityList = val;
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
        TextField(controller: nameController,),
        TextField(controller: descriptionController,),
        DropdownButton(
          hint: Text("Select Priority"),
            value: _selectedPriority,
            items: priorityList.map((e){
              return DropdownMenuItem(
                  child: Text(e.toString()));
            }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedPriority = value;
            });
        }, ),
        isLoading ? Center(child: CircularProgressIndicator(),)
        :
        ElevatedButton(onPressed: ()async{
          try{
            isLoading = true;
            setState(() {});
            await TaskServices().createTask(TaskModel(
              name: nameController.text.toString(),
              description: descriptionController.text.toString(),
              priorityID: _selectedPriority!.docId.toString(),
              isCompleted: false,
              createdAt: DateTime.now().millisecondsSinceEpoch
            )).then((val){
              isLoading = false;
              setState(() {});
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Create Successfully"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }, child: Text("Okay"))
                    ],
                  );
                }, );
            });
          }catch(e){
            isLoading =false;
            setState(() {});
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }, child: Text("Create Task"))
      ],),
    );
  }
}
