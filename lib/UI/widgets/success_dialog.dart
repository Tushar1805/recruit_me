import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  const Success({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Icon(Icons.check, size: 50, color: Colors.green,),
            SizedBox(height: 30,), 
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(child: Text("Done"))),
            SizedBox(height:20),
          ],
        ),
      ),
    );
  }
}