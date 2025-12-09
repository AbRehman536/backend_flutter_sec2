import 'package:flutter/material.dart';
import 'package:flutter_sec_2_backend/services/auth.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: Column(children: [
        TextField(controller: emailController,),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
              try{
                isLoading = true;
                setState(() {});
                await AuthServices().resetPasswrod(
                  emailController.text.toString(),
                ).then((value){
                  isLoading = false;
                  setState(() {});
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text("Link Send Successfully"),
                        actions: [
                          TextButton(onPressed: (){}, child: Text("Okay"))
                        ],
                      );
                    },);
                });
              }catch(e){
                isLoading =false;
                setState(() {});
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
        }, child: Text("Send Link"))
      ],),
    );
  }
}
