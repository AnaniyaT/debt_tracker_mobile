import 'package:flutter/material.dart';

class GenericDialog extends StatelessWidget {
  final String? text;
  const GenericDialog({this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),
            Text('Are you sure? ' + (text ?? ''), 
              style: TextStyle(
                fontSize: 17
              ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text('Yes'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text('No'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}