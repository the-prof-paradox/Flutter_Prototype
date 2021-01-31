import 'package:flutter/material.dart';
import 'userInput.dart';
class Op extends StatelessWidget {
  final Image outputImage = Image.asset('lib/assestss/op.JPG');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    Image.file(inputImage),
                    Text('Damaged!'),
                  ],
                ),
                Icon(Icons.arrow_forward),
                Column(
                  children: [
                    Image.asset('lib/assestss/op.JPG'),
                    Text('Restored!'),
                  ],
                ),
              ],
            ),
                    
            RaisedButton(
              child: Text("Share"),
              onPressed: (){
                
              }
              )
          ],
        ),
      ),
      
    );

  }
  
}