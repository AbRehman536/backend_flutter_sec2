import 'package:flutter/material.dart';
import 'package:flutter_sec_2_backend/models/priority.dart';
import 'package:flutter_sec_2_backend/services/priority.dart';
import 'package:flutter_sec_2_backend/views/create_priority.dart';
import 'package:provider/provider.dart';

class GetPriority extends StatelessWidget {
  const GetPriority({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Priority"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreatePriority(model: PriorityTaskModel(), isUpdateMode: false)));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
          value: PriorityServices().getAllPriority(),
          initialData: [PriorityTaskModel()],
          builder: (context, child){
            List<PriorityTaskModel> priorityList = context.watch<List<PriorityTaskModel>>();
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.task),
                  title: Text(priorityList[index].name.toString()),
                  trailing: IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePriority(model: PriorityTaskModel(), isUpdateMode: true)));
                  }, icon: Icon(Icons.edit)),
                );
              },);
          },
      ),
    );
  }
}
