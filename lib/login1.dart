import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }

}

class LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController otp = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isChecked =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.cyan[500],Colors.cyan[600]],begin: Alignment.topLeft,end: Alignment.topRight)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child:Row(children: [
                Padding(
                padding: const EdgeInsets.symmetric(vertical: 80.0,horizontal: 24.0),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                Text("Welcome to Back,",
              style: TextStyle(color: Colors.white,
              fontSize: 25.0,),),
              SizedBox(height: 10,),
               Text("Sign in to Continue",
              style: TextStyle(color: Colors.white,
              fontSize: 15.0,),),
              ]),),
              Expanded(
                child:Container(
                  padding: EdgeInsets.only(top: 80,bottom: 30),
                child: Image(image: AssetImage('assets/images/signin_icon.png'),
                ),),
              ),
              
              ]),
              ),
              Expanded(
                flex:5,
                child:Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text("Please verify your phone\nnumber for applying",style: TextStyle(color: Colors.cyan[500],fontSize: 20),),
                ),
                SizedBox(height: 40,),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0,),
                    decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.grey),
                                ),
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: mobileNo,
                        validator: (value) {
                          return value.isEmpty ? "Please Enter Mobile No." : null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: "Phone Number",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,)),
                      ),
                    ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.grey),
                                ),
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                    padding:
                    EdgeInsets.symmetric(horizontal: 20.0,),
                    child:
                    Row(children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: otp,
                        validator: (value) {
                          return value.isEmpty
                              ? "Please Enter OTP."
                              : null;
                        },
                        decoration: InputDecoration(
                            hintText: " The OTP Code",
                            border: OutlineInputBorder(borderSide: BorderSide.none),
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                                )),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 25,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.cyan,),
                        child: Center(child:Text("Get Code",style: TextStyle(fontWeight: FontWeight.bold,
                        color: Colors.white),),),
                      ))
              ],),
                    ),

                SizedBox(
                  height: 35.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    if(isChecked==false)
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(30.0)),
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              "SIGN IN",
                              textAlign: TextAlign.center,
                              
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    if(isChecked==true)
                      Expanded(
                      child: GestureDetector(
                        onTap: () {
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.circular(30.0)),
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              "SIGN IN",
                              textAlign: TextAlign.center,
                              
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool b){
                        setState(() {
                            isChecked =b;                      
                          });
                      }
                      ),
                    Container(
                      child: Text(
                        "I agree to",
                        style: TextStyle(fontSize: 10.0, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    GestureDetector(
                      onTap: (() {
                        
                      }),
                      child: Container(
                        child: Text(
                          "TERMS AND CONDITIONS, PRIVACY POLICY",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 10.0,
                              color: Colors.cyan),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "Don't have an account  ",
                        style: TextStyle(fontSize: 12.0, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    GestureDetector(
                      onTap: (() {
                        
                      }),
                      child: Container(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 12.0,
                              color: Colors.cyan),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),),
                ))
            ],
          ),
        ),
      ),
    );
  }
  
}