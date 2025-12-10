import 'package:flutter/material.dart';
import 'package:flutter_sec_2_backend/providers/user.dart';
import 'package:flutter_sec_2_backend/views/update_profile.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfile()));
          }, icon: Icon(Icons.edit))
        ],
      ),
      body: Column(children: [
        Text("Name: ${userProvider.getUser().name.toString()}",
        style: TextStyle(fontSize: 30),),
        Text("Email: ${userProvider.getUser().email.toString()}",
        style: TextStyle(fontSize: 30),),
        Text("Phone: ${userProvider.getUser().phone.toString()}",
        style: TextStyle(fontSize: 30),),
        Text("Address: ${userProvider.getUser().address.toString()}",
        style: TextStyle(fontSize: 30),),
      ],),
    );
  }
}
