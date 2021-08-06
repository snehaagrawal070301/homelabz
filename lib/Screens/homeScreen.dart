import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:homelabz/Screens/MakeAnAppointmentScreen.dart';
import 'package:homelabz/components/colorValues.dart';
import 'package:homelabz/constants/ConstantMsg.dart';
import 'package:homelabz/constants/apiConstants.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }

}

class HomeScreenState extends State<HomeScreen> {
  TextEditingController name= TextEditingController();
  TextEditingController mobile= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorValues.THEME_COLOR),
      body: SingleChildScrollView(
        child:Stack(
          children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 160, 0, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Color(ColorValues.WHITE_COLOR),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0))),
          ),
          Positioned(
            left: 5,
            top: 5,
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                 
                Expanded(flex:2,child: Image(image: AssetImage('assets/images/Menu.png'),height: 15.7,width: 26,)),
                Expanded(
                  flex: 10,
                   child: Text("Welcome to HomeLabz!",
                   textAlign: TextAlign.center,
                      style: TextStyle(color: Color(ColorValues.WHITE_COLOR),
                      fontFamily: "Regular",
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,),),
                 ),
                Expanded(flex:2,
                child:
                GestureDetector(
                  onTap: (){},
                child:Image(image: AssetImage('assets/images/profile.png'),height: 44,width: 44,),),
                 ),
                ],)
              
            ),
          ),
          Positioned(
            top:89,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(top: 9,bottom: 24,left: 56,right: 56),
                  height: MediaQuery.of(context).size.height*0.23,
                  width: MediaQuery.of(context).size.width*0.9,
                  decoration: BoxDecoration(
                    color: Color(ColorValues.WHITE_COLOR),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                      color: Colors.grey,
                      blurRadius: 7.0,
                      spreadRadius: 0.0,
                    )]
                  ),
                  child: Image.asset('assets/images/homeScreenLogo.png'),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.44,left: 25,right: 25),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),

                  child: 
                      Column(children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _bottomSheet(context);
                                    },
                                    child: Container(
                                      height: MediaQuery.of(context).size.height*0.17,
                                      width: MediaQuery.of(context).size.width*0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.0),
                                        color: Color(ColorValues.THEME_COLOR),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image(image: AssetImage('assets/images/Appointment.png'),height: 40,)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Make an\nAppointment ",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: "Regular",
                                                    color: Color(ColorValues.WHITE_COLOR),
                                                    fontSize: 14.0,
                                                    ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20.0),
                            Expanded(
                              flex: 1,
                              child: Column(children: [
                                GestureDetector(
                                  onTap: () {
                                  },
                                  child: Container(
                                     height: MediaQuery.of(context).size.height*0.17,
                                      width: MediaQuery.of(context).size.width*0.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Color(ColorValues.THEME_COLOR),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Image(image: AssetImage('assets/images/call.png'),height: 40,)
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Call for\nAppointment",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: "Regular",
                                                  color: Color(ColorValues.WHITE_COLOR),
                                                  fontSize: 14.0,
                                                  ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            )
                          ],
                        ),
                        SizedBox(height: 25.0),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                    },
                                    child: Container(
                                       height: MediaQuery.of(context).size.height*0.17,
                                      width: MediaQuery.of(context).size.width*0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.0),
                                        color: Color(ColorValues. THEME_COLOR),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image(image: AssetImage('assets/images/vault.png'),height: 50,)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Vault",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: "Regular",
                                                    color: Color(ColorValues.WHITE_COLOR),
                                                    fontSize: 14.0,
                                                    ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20.0),
                            Expanded(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                
                                    },
                                    child: Container(
                                       height: MediaQuery.of(context).size.height*0.17,
                                      width: MediaQuery.of(context).size.width*0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.0),
                                        color: Color(ColorValues.THEME_COLOR),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image(image: AssetImage('assets/images/history.png'),height: 40,)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "History",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: "Regular",
                                                    color: Color(ColorValues.WHITE_COLOR),
                                                    fontSize: 14.0,
                                                    ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    
                      ])      
                
        ),
        ]
          ) 
        ,),
        bottomNavigationBar: ConvexAppBar(
          color: Color(ColorValues.THEME_COLOR),
          backgroundColor: Color(ColorValues.THEME_COLOR),
          items:[
        TabItem(icon: Icons.home,title: "Home"),]
        ),
    );
  }
  _bottomSheet(context){
  showModalBottomSheet(context: context, builder: (BuildContext c){
    return Container(
      decoration: BoxDecoration(
          color: Color(ColorValues.WHITE_COLOR), 
            borderRadius: BorderRadius.only(topLeft:Radius.circular(10),
            topRight:Radius.circular(10)
            )),
      
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
          child:Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(top:20,left: 17,bottom: 15),
              child: Text("Login or Register",style: TextStyle(fontSize: 12,color: Color(0xff000000),fontFamily: "Regular",),),
            ),
            Divider(
              height: 2,color: Color(ColorValues.BLACK_COLOR),),
             
            GestureDetector(
              onTap: (){
                _bottomSheet1(context);
              },
              child: Container(
                margin: EdgeInsets.only(top: 30,bottom: 10,left: 25,right: 25),
                padding: EdgeInsets.symmetric(horizontal: 25),
                height: 33,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(ColorValues.THEME_COLOR),
                  borderRadius: BorderRadius.circular(10.0)),
                  child: Center(child: Text("Continue with Phone",style: TextStyle(color: Color(ColorValues.WHITE_COLOR),
                  fontFamily: "Regular",fontSize: 14,fontWeight: FontWeight.bold,),textAlign:TextAlign.center ,)),
                ),
            ),
              Container(
                margin: EdgeInsets.symmetric(vertical:10,horizontal: 25),
              padding: EdgeInsets.symmetric(horizontal: 25),
              height: 33,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: Color(ColorValues.BLACK_COLOR)),
                borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 52),
                      child:Image(image: AssetImage("assets/images/googleIcon.png"),height: 14,width: 14,),),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("Continue with Google",style: TextStyle(color: Color(ColorValues.BLACK_COLOR),
                      fontFamily: "Regular",fontSize: 14,fontWeight: FontWeight.bold,),textAlign:TextAlign.center ,)), 
                  ],
                ),
              ),
              GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child:
              Container(
                margin: EdgeInsets.only(top:10,bottom: 10),
                child: Text("Cancel",style:TextStyle(fontSize: 14,color: Color(ColorValues.BLACK_TEXT_COL),fontFamily: "Regular",) ,textAlign: TextAlign.center,))),
          ],
        ) ,),
    );
  }
  );
}
_bottomSheet1(context){
  showModalBottomSheet(context: context, builder: (context){
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: Color(ColorValues.WHITE_COLOR), 
              borderRadius: BorderRadius.only(topLeft:Radius.circular(10),
              topRight:Radius.circular(10)
              )),
        
        width: MediaQuery.of(context).size.width,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              
            children: [
              Container(
                padding: EdgeInsets.only(top: 38),
                child: Text("Register",style: TextStyle(fontSize: 20,color: Color(ColorValues.THEME_COLOR),fontFamily: "Regular",),),
              ),
              Container(
                padding: EdgeInsets.only(top: 50),
                child: Image(image: AssetImage("assets/images/RegisterIcon.png"),height: 66,width: 66,),
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: Text("Enter Your Mobile Number",style: TextStyle(fontSize: 14,color: Color(ColorValues.BLACK_COLOR),fontFamily: "Black",),),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Center(child: Text("We will send you one time\npassword(OTP)",style: TextStyle(fontSize: 14,color: Color(ColorValues.BLACK_TEXT_COL),fontFamily: "Regular",),textAlign: TextAlign.center,)),
              ),
              Container(
                
                padding: EdgeInsets.symmetric(horizontal: 100),
                child:TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: mobile,
                  validator: (value) {
                            return value.isEmpty ? ConstantMsg.NAME_VALIDATION : null;
                          },
                  decoration: InputDecoration(
                              hintText: "Enter Mobile Number",
                              hintStyle: TextStyle(
                                  color: Color(0xffBDBDBD),
                                  fontSize: 12.0,
                                  fontFamily: "Regular",),
                                  
                                  ),
                  
                )
              ),
              GestureDetector(
                onTap: (){
                  _bottomSheet2(context);
                },
                child: Container(
                  height:35,
                  width: MediaQuery.of(context).size.width*0.53,
                  margin: EdgeInsets.symmetric(vertical: 25),
                  decoration: BoxDecoration(
                    color: Color(ColorValues.THEME_COLOR),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text("SEND",style: TextStyle(color: Color(0xffFFFFFF),fontSize: 14,fontFamily: "Bold",),)),
                ),
              ),
              
            ],
          ) ,
      ),
    );
  }
  );
}

_bottomSheet2(context){
  showModalBottomSheet(context: context, builder: (context){
    return Container(
      decoration: BoxDecoration(
          color: Color(ColorValues.WHITE_COLOR), 
            borderRadius: BorderRadius.only(topLeft:Radius.circular(10),
            topRight:Radius.circular(10)
            )),
      
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(top:20,left: 17,bottom: 15),
              child: Text("Login or Register",style: TextStyle(fontSize: 12,color: Color(ColorValues.BLACK_TEXT_COL),fontFamily: "Regular",),),
            ),
            Divider(
              height: 2,color: Color(ColorValues.BLACK_COLOR),),
            Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.only(left: 27,bottom: 5),
              height: 38,
              width: MediaQuery.of(context).size.width*0.85,
              decoration: BoxDecoration(
                 border: Border.all(color: Color(ColorValues.BLACK_COLOR)),
                color: Color(ColorValues.LIGHT_GRAY),
                borderRadius: BorderRadius.circular(10.0)),
                child:
                    TextFormField(
                      controller: name,
                      keyboardType: TextInputType.text,
                      validator: (value) => value.isEmpty
                                    ? 'Enter Your Name'
                                    : RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                    .hasMatch(value)
                                    ? 'Enter a Valid Name'
                                    : value.length < 3
                                    ? 'Name must contain more than 3 characters'
                                    : null,
                      decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Full Name",
                                  hintStyle: TextStyle(
                                      
                                      color: Color(ColorValues.BLACK_TEXT_COL),
                                      fontSize: 12.0,
                                      fontFamily: "Regular",),
                                     
                                      ),
                    ),
                
                ),
              
              GestureDetector(
                onTap: (){
                  _bottomSheet3(context);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 22),
                padding: EdgeInsets.symmetric(horizontal: 27),
                height: 33,
                width: MediaQuery.of(context).size.width*0.85,
                decoration: BoxDecoration(
                  color: Color(ColorValues.THEME_COLOR),
                  borderRadius: BorderRadius.circular(10.0)),
                        child: Center(child: Text("Continue",style: TextStyle(color: Color(ColorValues.WHITE_COLOR),fontSize: 14,fontFamily: "Regular",fontWeight: FontWeight.bold,),textAlign:TextAlign.center ,))
                    
                ),
              ),
              GestureDetector(
                onTap: (){
                  _bottomSheet1(context);
                },
                child:Container(
                margin: EdgeInsets.only(top: 12,bottom: 10),
                child: Text("Cancel",style:TextStyle(fontSize: 14,color: Color(ColorValues.BLACK_TEXT_COL)) ,textAlign: TextAlign.center,)))
          ],
        ) ,),
    );
  }
  );
}

_bottomSheet3(context){
  showModalBottomSheet(context: context, builder: (context){
    return Container(
      decoration: BoxDecoration(
          color: Color(ColorValues.WHITE_COLOR), 
            borderRadius: BorderRadius.only(topLeft:Radius.circular(10),
            topRight:Radius.circular(10)
            )),
      
      width: MediaQuery.of(context).size.width,
          child:SingleChildScrollView(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 32),
                  child: Text("Verify Account",style: TextStyle(fontSize: 20,fontFamily: "Regular",color: Color(ColorValues.THEME_COLOR)),),
                ),
                Container(
                  margin: EdgeInsets.only(top: 33),
                  child: Text("Mobile Verification has\nsuccessfully done",style: TextStyle(fontSize: 13,color: Color(ColorValues.BLACK_COLOR),fontFamily: "Black",),textAlign: TextAlign.center,),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Center(child: Text("To complete your registration, we have sent\nan OTP to ${this.mobile.text} to verify",style: TextStyle(fontSize: 12,fontFamily: "Regular",color: Color(ColorValues.BLACK_TEXT_COL)),textAlign: TextAlign.center,)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  margin: EdgeInsets.only(top: 30,),
                  child: TextField(
                          autofocus: false,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Regular",
                            color: Color(ColorValues.BLACK_TEXT_COL),
                          ),
                          decoration: new InputDecoration(
                            
                            labelStyle: TextStyle(
                              fontSize: 12,
                              fontFamily: "Regular",
                              fontWeight: FontWeight.w700,
                              color: Color(ColorValues.THEME_TEXT_COLOR),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                          ),
                        ),
                  
                ),
                Container(
                  margin: EdgeInsets.only(top:24,),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("If you didn’t recieve your code ?",style: TextStyle(fontSize: 10,fontFamily: "Regular",color: Color(0xff707070)),textAlign: TextAlign.center,),
                      Text("Resend",style: TextStyle(fontSize: 10,fontFamily: "Regular",color: Color(ColorValues.THEME_COLOR)),textAlign: TextAlign.center)
                    ],
                  ),
                  
                ),
                GestureDetector(
                  onTap: (){
                
                   callLoginApi();
                  },
                  child: Container(
                    height:33,
                    width: MediaQuery.of(context).size.width*0.53,
                    margin: EdgeInsets.only(top: 26,bottom: 15),
                    decoration: BoxDecoration(
                      color: Color(ColorValues.THEME_COLOR),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text("VERIFY",style: TextStyle(color: Color(ColorValues.WHITE_COLOR),fontFamily: "Regular",fontSize: 14),)),
                  ),
                )
              ],
        ),
          ) ,
    );
  }
  );
}

 void callLoginApi() async {
    try {
      var url = Uri.parse(ApiConstants.VERIFY_OTP_API);
      Map<String, String> headers = {"Content-type": "application/json"};
      Map mapBody = {
        // "mobileNumber": _phone.text,
        // "otp": _otp.text

        ConstantMsg.MOBILE_NUM: "1111111110",
        ConstantMsg.OTP: 123456
      };
      // make POST request
      Response response =
          await post(url, headers: headers, body: json.encode(mapBody));

      String body = response.body;
      var data = json.decode(body);

      if (data["oAuthResponse"].toString() != null) {
        print(body);

        Navigator.pushReplacement(
          context,
            new MaterialPageRoute(
                builder: (BuildContext context) => MakeAnAppointScreeen()));
      } else {}
    } catch (e) {
      print("Error+++++" + e.toString());
    }
  }
}