import 'package:flutter/material.dart';
import 'package:weather_app/pages/welcome.dart';

import '../models/constants.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    Constants myconstants=Constants();
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: myconstants.primaryColor.withOpacity(0.5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/get-started.png'),
             const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Welcome()));
                },
                child: Container(
                  height: 50,
                  width: size.width*0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: myconstants.primaryColor
                  ),
                  child:const Center(
                    child: Text('Get Started',style: TextStyle(color: Colors.white,fontSize: 18),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
