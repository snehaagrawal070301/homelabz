import 'package:flutter/material.dart';
import 'package:homelabz/Models/TimeSlot.dart';
import 'package:homelabz/components/colorValues.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
//  final List<Map> myProducts =
//  List.generate(9, (index) => {"id": index, "name": "Product $index"})
//      .toList();
  List<TimeSlot> slots = [];
  List quotationList = [];

  void fillDataInList() {
 // List quotationList = [];
    slots.add( TimeSlot("08:00","09:00"));
    slots.add( TimeSlot("09:00","10:00"));
    slots.add( TimeSlot("10:00","11:00"));
    slots.add( TimeSlot("11:00","12:00"));
    slots.add( TimeSlot("12:00","01:00"));
    slots.add( TimeSlot("01:00","02:00"));

      print(slots.length);
  }

  @override
  void initState(){
    super.initState();
    fillDataInList();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 100,left: 20,right: 20),
        height: MediaQuery.of(context).size.height*0.4,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Color(ColorValues.WHITE_COLOR),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
                spreadRadius: 0.5,
              )]
        ),
        child:
            Container(
//              height: 50,
              color: Color(0xffF6F6F6),
              margin: EdgeInsets.symmetric(horizontal: 20),
              child:  GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 4),
                  ),

                  itemCount: slots.length,
                      itemBuilder: (BuildContext ctx, pos) {
                        return Container(
                            width: 30,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Color(0xff1D2A4D),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Text(slots[pos].startTime),
                                Text(slots[pos].endTime)
                              ],
                            ),
                        );
                      }),
            ),

      ),
    );
  }
}
