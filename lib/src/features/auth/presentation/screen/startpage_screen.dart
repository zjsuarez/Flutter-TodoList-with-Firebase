

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todolistfirebase/src/core/constants/app_colors.dart';

class StartPageScreen extends StatelessWidget {
  const StartPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppColors.backgroundcolor),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 180,),
            Image(image: AssetImage('assets/images/todo_icon.png'), width: 500,),
            Text('TaskR', style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),),
            Text('Todo List App developed by Justin Suarez' , style: TextStyle(color: Color.fromARGB(185, 108, 108, 108), fontSize: 12, fontWeight: FontWeight.w500),),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                context.go('/register');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text('Get Started', style: TextStyle(color: Colors.white, fontSize: 16),),
            ),
            SizedBox(height: 10,),
            TextButton(onPressed: () {
              context.go('/login');
            }, child: Text('I Already have an account', style: TextStyle(color: Colors.black54),)),
            SizedBox(height: 40,)
          ],
        )
      ),);
  }
}