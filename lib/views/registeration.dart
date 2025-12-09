import 'package:flutter/material.dart';
import 'package:flutter_sec_2_backend/models/user.dart';
import 'package:flutter_sec_2_backend/services/auth.dart';
import 'package:flutter_sec_2_backend/services/user.dart';

class Registeration extends StatefulWidget {
  const Registeration({super.key});

  @override
  State<Registeration> createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: Column(children: [
        TextField(controller: nameController,decoration: InputDecoration(
          label: Text("Name")),),
        TextField(controller: emailController,decoration: InputDecoration(
          label: Text("Email")),),
        TextField(controller: passwordController,decoration: InputDecoration(
          label: Text("Password")),),
        TextField(controller: cpasswordController,decoration: InputDecoration(
          label: Text("Confirm Password")),),
        TextField(controller: addressController,decoration: InputDecoration(
          label: Text("Address")),),
        TextField(controller: phoneController,decoration: InputDecoration(
          label: Text("Phone")),),
        isLoading ? Center(child: CircularProgressIndicator(),):
        ElevatedButton(onPressed: ()async{
          try{
            isLoading = true;
            setState(() {});
            await AuthServices().registerUser(
                email: emailController.text.toString(),
                password: passwordController.text.toString())
                .then((user){
                  UserServices().createUser(UserModel(
                    name: nameController.text.toString(),
                    email: emailController.text.toString(),
                    address: addressController.text.toString(),
                    phone: phoneController.text.toString()
                  )).then((value){
                    isLoading =false;
                    setState(() {});
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("Register Successfully"),
                          actions: [
                            TextButton(onPressed: (){}, child: Text("Okay"))
                          ],
                        );
                      },);
                  });
            });
          }catch(e){
            isLoading =false;
            setState(() {});
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }, child: Text("Register"))
      ],),
    );
  }
}
