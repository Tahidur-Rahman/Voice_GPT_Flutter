import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:voiceassistant/pallete.dart';

class BoxItem extends StatelessWidget {
  final Color color;
  final String title;
  final String description;
  const BoxItem({Key? key, required this.color,required this.title, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(title,style: TextStyle(
              fontFamily: 'Cera-Pro',
              color:Pallete.blackColor,
              fontSize:20,
              fontWeight: FontWeight.bold
            )),
      ),
      SizedBox(height: 5,),
      Text(description,style: TextStyle(
            fontFamily: 'Cera-Pro',
            color:Pallete.blackColor,
          )),
      ]),
    );
  }
}