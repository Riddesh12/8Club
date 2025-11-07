import 'dart:convert';

import 'package:club8/Experience/experience_images.dart';
import 'package:club8/Onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Experience extends StatefulWidget {
  const Experience({super.key});

  @override
  State<Experience> createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> {
  Future<List<dynamic>>fetchResult()async{
    final response= await http.get(
      Uri.parse('https://staging.chamberofsecrets.8club.co/v1/experiences?active=true'),
    );
    if(response.statusCode==200) {
      final data = jsonDecode(response.body);
      if (data is Map && data.containsKey('data') &&
          data['data'].containKey('experience')) {
        return data['data']['experience'];
      }
      else {
        throw Exception("Error");
      }
    }
      else{
        throw Exception('Failed');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: SafeArea(child: LayoutBuilder(
          builder:(context, Constaints){
               return SingleChildScrollView(
                 padding: EdgeInsets.only(
                   bottom: MediaQuery.of(context).viewInsets.bottom),
                 child: ConstrainedBox(
                     constraints: BoxConstraints(minHeight: Constaints.maxHeight),
                   child: IntrinsicHeight(
                     child: Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           Text("What kind of hotspots do you want to host?",
                           style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 24,
                               color: Colors.white,
                               fontFamily: "SpaceGrotesk"
                           ),),
                           SizedBox(height: 15,),
                           //------------Add api functions for carrdsssss----------------------------
                        Club(),
                           SizedBox(height: 10,),
                           TextFormField(
                             style: TextStyle(
                               color: Colors.white,
                             ),
                             minLines: 5,
                             maxLines: null,
                             maxLength: 250,
                             decoration: InputDecoration(
                               hintText: "/ Describe your perfect hotspot",
                                 hintStyle: TextStyle(
                                   fontFamily: "SpaceGrotesk",
                                   fontSize: 18,
                                   fontWeight: FontWeight.bold,
                                 ),
                               counterText: "",
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10),
                                 borderSide: BorderSide(color: Colors.white)
                               )
                             ),
                           ),
                           SizedBox(height: 20,),
                           Container(

                            height: 50,
                             width: double.infinity,
                             decoration: BoxDecoration(
                               gradient: LinearGradient(colors: [
                                 Colors.black26,
                                 Colors.white24,
                                 Colors.black12
                               ],
                                   begin: Alignment.centerLeft,
                                   end: Alignment.centerRight
                               ),
                               borderRadius: BorderRadius.circular(10),
                                 border: Border.all(
                                   color: Colors.white24,
                                   width: 1,
                                 )

                             ),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>Onboarding()));
                          },
                          child: Center(

                               child:  Text("Next",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: "SpaceGrotesk",
                              color: Colors.grey),),
                          ),
                        ),
                           )
                         ],
                       ),
                     ),
                   ),
                 ),

               );
      }
      )
      ),
    );
  }
}
