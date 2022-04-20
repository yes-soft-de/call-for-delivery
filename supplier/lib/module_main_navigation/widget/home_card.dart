import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;


  HomeCard({required this.title,required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child:
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(image,height: 100,width: 130,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600),),
              )
          ],),
        ),),
      ),
    );
  }
}
