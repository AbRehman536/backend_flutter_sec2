import 'package:flutter/material.dart';
import 'package:flutter_sec_2_backend/services/auth.dart';
import 'package:flutter_sec_2_backend/views/get_all_task.dart';
import 'package:flutter_sec_2_backend/views/registeration.dart';
import 'package:flutter_sec_2_backend/views/reset_password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(children: [
        TextField(controller: emailController,),
        TextField(controller: passwordController,),
        isLoading ? Center(child: CircularProgressIndicator(),)
            :ElevatedButton(onPressed: ()async{
              try{
                await AuthServices().loginUser(
                    email: emailController.text.toString(),
                    password: passwordController.text.toString()).then((val){
                      isLoading = true;
                      setState(() {});
                      if(val!.emailVerified == true){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllTask()));
                      }else{
                        isLoading = false;
                        setState(() {});
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text("Kindly Verify Your Email"),
                              actions: [
                                TextButton(onPressed: (){}, child: Text("Okay"))
                              ],
                            );
                          },);
                      }
                });
              }catch(e){
                isLoading =false;
                setState(() {});
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
        }, child: Text("Login")),
        TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Registeration()));
        }, child: Text("Register")),
        TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
        }, child: Text("Reset Password")),
      ],),
    );
  }
}
