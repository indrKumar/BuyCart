import 'package:flutter/material.dart';

class NotificationDetails extends StatelessWidget {
  static String id = "NotificationDetails";
  const NotificationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("There are many variations of Lore ipsum available",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            SizedBox(height: 10,),
            Text("10 min ago",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12),),
              SizedBox(
                height: 10,
              ),
              Text(
              """Dear User,
          
As you are already aware, we have approached in the final stretch of this academic year and We firmly acknowledge your dedication towards student, continuity over classes and the hard work you have put over the year. This is very crucial time for student to ensure him uninterrupted support and guidance.
          
In light of this, we would like to remind all tutors that no leave requests will be approved until the conclusion of the examination period.
          
During this critical time, our commitment to our students is of utmost priority. Any absence without prior approval will result in a deduction of 20% from your monthly salary.
          
We appreciate your understanding and cooperation in maintaining the academic continuity for our students. If you face any unavoidable circumstances, please reach out to the management well in advance to discuss possible solutions.
Thank you for your dedication to our institution and the success of our students.
          
Best Regards,""",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              
              SizedBox(height: 20,),
              Icon(Icons.link),
              SizedBox(height: 20,),
              Image(image: AssetImage("assets/girl.png"),height: 60,width: 60,),
              SizedBox(height: 30,),
            ],),
        ),
      ),
    );
  }
}
