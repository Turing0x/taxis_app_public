import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {

  final String text;
  final Function onPressed;

  const BotonAzul({
    Key? key, 
    required this.text, 
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle( 
        backgroundColor: MaterialStatePropertyAll(Colors.blue), 
        elevation: MaterialStatePropertyAll(2),
       
         iconColor: MaterialStatePropertyAll(Colors.blue),
        shape: MaterialStatePropertyAll(StadiumBorder()),),
       
        onPressed: () {
          onPressed;
        },
        child: Container(
          width: double.infinity,
          height: 55,
          child: Center(
            child: Text( this.text , style: TextStyle( color: Colors.white, fontSize: 17 )),
          ),
        ),
    );
  }

}