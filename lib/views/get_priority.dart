import 'package:flutter/material.dart';
import 'package:flutter_sec_2_backend/models/priority.dart';
import 'package:flutter_sec_2_backend/services/priority.dart';
import 'package:flutter_sec_2_backend/views/create_priority.dart';
import 'package:flutter_sec_2_backend/views/get_priority_by_id.dart';
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreatePriority(model: PriorityModel(), isUpdateMode: false)));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
          value: PriorityServices().getAllPriorities(),
          initialData: [PriorityModel()],
          builder: (context, child){
            List<PriorityModel> priorityList = context.watch<List<PriorityModel>>();
            return ListView.builder(
              itemCount: priorityList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.task),
                  title: Text(priorityList[index].name.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePriority(model: PriorityModel(), isUpdateMode: true)));
                      }, icon: Icon(Icons.edit)),
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>GetPriorityID(model: PriorityModel())));
                      }, icon: Icon(Icons.arrow_forward_ios)),
                    ],
                  ),
                );
              },);
          },
      ),
    );
  }
}
