import 'package:flutter/material.dart';

class GoogleIconButton extends StatelessWidget {
  void Function()? google;
  GoogleIconButton({super.key,required this.google});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>google,
      borderRadius: BorderRadius.circular(16), // Ripple effect rounded corners
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Background color
          borderRadius: BorderRadius.circular(16), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
        child: Image.asset(
          'assets/flattIcon/google.png',
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
