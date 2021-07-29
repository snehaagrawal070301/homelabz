import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelabz/paymentScreen.dart';

class AppointmentScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AppointmentScreenState();
  }

}

class AppointmentScreenState extends State<AppointmentScreen>{
  String type = 'Preferred Lab';
  String gender="male";
  TextEditingController address = TextEditingController();
  TextEditingController dob = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xffFFFFFF),
        leading: IconButton(
            icon: Icon(
            Icons.arrow_back,
            color: Color(0xff21C8BE),
            ),
          onPressed: () {
            Navigator.pop(context);
          },
    ),
        title: Text("Appointment",style: TextStyle(fontFamily: "Regular",fontSize: 18,
        color: Color(0xff21C8BE)),),
      ),
      body:
      SingleChildScrollView(
        child:
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 500),
              width: MediaQuery.of(context).size.width,
              height: 162,
              color: Color(0xff21C8BE),   
          ),
          Positioned(
              left: 17,
              right: 17,
              top:98,
              bottom: 40,
              child: Container(
                height: 645,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                    color: Colors.grey,
                    blurRadius: 7.0,
                    spreadRadius: 0.0,
                  )]
                ),
                child: ListView(children: [
                   Container(
                      margin: EdgeInsets.only(top: 31,right: 20,left: 20),
                      padding: EdgeInsets.only(left: 18),
                      height: 38,
                      width: 301,
                      decoration: BoxDecoration(
                      color: Color(0xffF9F8F8),
                      border: Border.all(color: Color(0xff000000),width: 1),
                      borderRadius: BorderRadius.circular(10),
                        ),
                      child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: type,
                        iconSize: 24,
                        dropdownColor: Color(0xffFFFFFF),
                        iconEnabledColor: Color(0xff000000),
                        focusColor: Color(0xffFFFFFF),
                        elevation: 16,
                        style: TextStyle(color: Color(0xff707070),fontSize: 12,fontFamily: "Regular"),
                        onChanged: (String newValue) {
                          setState(() {
                            type = newValue;
                          });
                        },
                        items: <String>['Preferred Lab', 'Electronic bank transfer']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )),
                     Container(
                      margin: EdgeInsets.only(top: 24,right: 20,left: 20),
                      padding: EdgeInsets.only(left: 18),
                      height: 38,
                      width: 301,
                      decoration: BoxDecoration(
                      color: Color(0xffF9F8F8),
                      border: Border.all(color: Color(0xff000000),width: 1),
                      borderRadius: BorderRadius.circular(10),
                        ),
                      child: TextFormField(
                        controller: address,
                        validator: (value) {
                          return value.isEmpty ? "Please Enter Address" : null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: "Address",
                            hintStyle: TextStyle(
                                color: Color(0xff707070),
                                fontSize: 12.0,
                                fontFamily: "Regular")),
                      ),
                      ),
                      Container(
                      margin: EdgeInsets.only(top: 24,right: 20,left: 20),
                      padding: EdgeInsets.only(left: 18),
                      height: 38,
                      width: 301,
                      decoration: BoxDecoration(
                      color: Color(0xffF9F8F8),
                      border: Border.all(color: Color(0xff000000),width: 1),
                      borderRadius: BorderRadius.circular(10),
                        ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: dob,
                        validator: (value) {
                          return value.isEmpty ? "Please Enter date of birth" : null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                            hintText: "Date of Birth",
                            hintStyle: TextStyle(
                                color: Color(0xff707070),
                                fontSize: 12.0,
                                fontFamily: "Regular")),
                      ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 14,left: 20,right: 20),
                        child: Text("Gender",style: TextStyle(fontFamily: "Black",fontSize: 12,color: Color(0xff000000)),),
                      ),
                      Container(
                        height: 36,
                        margin: EdgeInsets.only(top: 11,left: 20,right: 20),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: (){
                                    gender="male";
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff21C8BE),
                                       borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                    ),
                                    child: Center(child: Text("Male",style: TextStyle(fontFamily: "Regular",fontSize: 12,color: Color(0xffFFFFFF),fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                                  ),
                                )
                                ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: (){
                                    gender="female";
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffF9F8F8),
                                       borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                      border: Border.all(color: Color(0xff000000),width: 1),
                                    ),
                                    child: Center(child: Text("Female",style: TextStyle(fontFamily: "Regular",fontSize: 12,color: Color(0xff21C8BE),fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                                  ),
                                )
                                ),
                            ],
                          ),
                      ),
                      Container(
                      margin: EdgeInsets.only(top: 18,right: 20,left: 20),
                      padding: EdgeInsets.only(left: 18),
                      height: 74,
                      width: 301,
                      decoration: BoxDecoration(
                      color: Color(0xffF9F8F8),
                      border: Border.all(color: Color(0xff000000),width: 1),
                      borderRadius: BorderRadius.circular(10),
                        ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Image(
                                image: AssetImage("assets/images/uploadLogo.png"),
                                height: 28,
                                width: 25,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                          Container(
                          child: Text("Upload your prescription",style: TextStyle(fontFamily: "Regular",fontWeight: FontWeight.bold,fontSize: 12,color: Color(0xff707070)),textAlign:TextAlign.center,),
                      ),
                        ],
                      ),
                      ),
                     GestureDetector(
                      onTap: (){
                     Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PaymentScreen()));
                     },
                    child: Container(
                      margin: EdgeInsets.only(top:20,left: 20,right: 20),
                    height: 38,
                    width: 301,
                    decoration: BoxDecoration(
                      color: Color(0xff21C8BE),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Center(
                      child: Text("CONTINUE",style: TextStyle(fontFamily: "Regular",fontSize: 15,
                      color: Color(0xffFFFFFF)),textAlign: TextAlign.center,),),
                ),
                    ),
                  SizedBox(
                    height: 30,
                  )
                ],),
              ),
            ),
            Positioned(
              top: 15,
              right: 15,left: 257,
              child: Image(
                height: 57,
                width: 103,
                image: AssetImage("assets/images/appointmentUndraw.png"),
              )),
            Positioned(
              top: 32,
              left: 17,
              child: Text("Patient Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,
              fontFamily: "Regular",color: Color(0xffFFFFFF)),)
              )
          ]),
      )
    );
  }
}