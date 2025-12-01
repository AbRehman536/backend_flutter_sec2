import 'package:flutter/material.dart';
import 'package:flutter_sec_2_backend/models/priority.dart';
import 'package:flutter_sec_2_backend/services/priority.dart';

class CreatePriority extends StatefulWidget {
  final PriorityTaskModel model;
  final bool isUpdateMode;
  const CreatePriority({super.key, required this.model, required this.isUpdateMode});

  @override
  State<CreatePriority> createState() => _CreatePriorityState();
}

class _CreatePriorityState extends State<CreatePriority> {
  TextEditingController nameController =  TextEditingController();
  bool isLoading = false;

  @override
  void initState(){
    nameController = TextEditingController(
        text: widget.model.name.toString()
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdateMode ? "Update Task" : "Create Task"),
        backgroundColor: widget.isUpdateMode ? Colors.blue : Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
        TextField(controller: nameController,),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
              try{
                isLoading = true;
                setState(() {});
                if(widget.isUpdateMode == true){
                  await PriorityServices().updatePriority(PriorityTaskModel(
                    docId: widget.model.docId,
                    name: nameController.text.toString(),
                    createdAt: DateTime.now().millisecondsSinceEpoch
                  )).then((val){
                    isLoading = false;
                    setState(() {});
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("Update Task Successfully"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text("Okay"))
                          ],
                        );
                      },);
                  });
                }else{
                  await PriorityServices().createPriority(PriorityTaskModel(
                      name: nameController.text.toString(),
                      createdAt: DateTime.now().millisecondsSinceEpoch
                  )).then((val){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("Create Task Successfully"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text("Okay"))
                          ],
                        );
                      },);
                  });
                }
              }catch(e){
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
              }
        },
            child: Text(widget.isUpdateMode == true ?
            "Update Task" : "Create Task"))
      ],),
    );
  }
}
