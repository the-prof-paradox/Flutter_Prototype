import 'package:flutter/material.dart';
import 'userInput.dart';
import 'paymentGateway.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  //hintText: 'Enter valid mail id as abc@gmail.com'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter your secure password'
                ),
              ),
            ),
            FlatButton(
              onPressed: (){
                //FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            RaisedButton(
              child: Text('Login'),
              onPressed: (){
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  child: AlertDialog(
                    content: Text('Login success!'),
                    actions: [
                      FlatButton(
                        onPressed: (){
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Input()));
                      }, 
                      child: Text('OK'))
                    ],
                  )
                  );
              }),
              SizedBox(
              height: 130,
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Payments()));
                
              },
              child: Text('New User? Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}