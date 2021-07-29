import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelabz/bookingScreen.dart';
import 'package:homelabz/bookingSuccess.dart';

class PaymentScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PaymentScreenState();
  }

}

class PaymentScreenState extends State<PaymentScreen>{
  int _radioValue = 1;
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
      }
    });
  }
  String type = 'Credit/Debit/ATM Card';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
        title: Text("Payment",style: TextStyle(fontFamily: "Regular",fontSize: 18,
        color: Color(0xff21C8BE)),),
      ),
      body: 
      SingleChildScrollView(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 65),
              child: Image(
                height: 245,
                width: 245,
                image: AssetImage("assets/images/PaymentScreen.png"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 39,left: 30),
              child: Text("Select payment method",style: 
              TextStyle(fontFamily:"Poppins",fontSize: 13,color:Color(0xff767676) ),),
            ),
            Container(
                      margin: EdgeInsets.only(top: 16,right: 30,left: 30),
                      padding: EdgeInsets.only(left: 16),
                      height: 43,
                      width: 315,
                      decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 7.0,
                        spreadRadius: 1.0,
                        )]
                        ),
                      child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: type,
                        iconSize: 24,
                        dropdownColor: Color(0xffFFFFFF),
                        iconEnabledColor: Color(0xff000000),
                        focusColor: Color(0xffFFFFFF),
                        elevation: 16,
                        style: TextStyle(color: Color(0xff000000),fontSize: 14,fontFamily: "Black"),
                        onChanged: (String newValue) {
                          setState(() {
                            type = newValue;
                          });
                        },
                        items: <String>['Credit/Debit/ATM Card', 'Electronic bank transfer']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )),
              Container(
                margin: EdgeInsets.only(top: 39,left: 28),
                 child:Row(
                      children: [
                        Radio(
                          value: 0,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        Text(
                          "Add New Card",
                          style: TextStyle(fontSize: 12.0, color: Color(0xff767676)),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                      ),
                  Container(
                      margin: EdgeInsets.only(top: 13,right: 30,left: 30),
                      height: 206,
                      width: 315,
                      decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 7.0,
                        spreadRadius: 1.0,
                        )]
                        ),
                   ), 
                  GestureDetector(
                    onTap: (){
                     Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BookingSuccessScreen()));
                  },
                    child: Container(
                      margin: EdgeInsets.only(top:35,left: 30),
                    height: 38,
                    width: 315,
                    decoration: BoxDecoration(
                      color: Color(0xff21C8BE),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text("CONFIRM AND PAY",style: TextStyle(fontFamily: "Regular",fontSize: 15,
                      color: Color(0xffFFFFFF)),textAlign: TextAlign.center,),),
                ),
                    ),
                  SizedBox(
                    height: 30,
                  )      
                    ]),
            ),
    );
  }
}