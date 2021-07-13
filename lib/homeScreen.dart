import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';


class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }

}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21C8BE),
      body: SingleChildScrollView(
        child:Stack(
          children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 160, 0, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
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
                 
                Expanded(flex:2,child: Image(image: AssetImage('assets/Menu.png'),height: 15.7,width: 26,)),
                Expanded(
                  flex: 10,
                   child: Text("Welcome to HomeLabz!",
                   textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,
                      fontSize: 18.0,),),
                 ),
                Expanded(flex:2,
                child:
                GestureDetector(
                  onTap: (){
                    _bottomSheet(context);
                  },
                child:Image(image: AssetImage('assets/profile.png'),height: 44,width: 44,),),
                 ),
                ],)
              
            ),
          ),
          Positioned(
            left: 30,
            top:89,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 56),
              height: 157,
              width: 339,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(10),
                
              ),
              child: Image.asset('assets/homeScreenLogo.png'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:325,left: 25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(70),
                      topLeft: Radius.circular(70)),
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
                                    },
                                    child: Container(
                                      height: 128,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.0),
                                        color: Colors.cyan,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image(image: AssetImage('assets/Appointment.png'),height: 40,)
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
                                                    color: Colors.white,
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
                                    height: 128,
                                      width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.cyan,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Image(image: AssetImage('assets/call.png'),height: 40,)
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
                                                  color: Colors.white,
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
                                      height: 128,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.0),
                                        color: Colors.cyan,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image(image: AssetImage('assets/vault.png'),height: 50,)
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
                                                    color: Colors.white,
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
                                      height: 128,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.0),
                                        color: Colors.cyan,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Image(image: AssetImage('assets/history.png'),height: 40,)
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
                                                    color: Colors.white,
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
          items:[
        TabItem(icon: Icons.home,title: "Home"),]
        ),
    );
  }
  _bottomSheet(context){
  showModalBottomSheet(context: context, builder: (BuildContext c){
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffFFFFFF), 
            borderRadius: BorderRadius.only(topLeft:Radius.circular(10),
            topRight:Radius.circular(10)
            )),
      height: 228,
      width: 375,
      child: SingleChildScrollView(
          child:Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(top:20,left: 17,bottom: 15),
              child: Text("Login or Register",style: TextStyle(fontSize: 12,color: Color(0xff000000)),),
            ),
            Divider(
              height: 2,color: Color(0xff000000),),
            Container(
              margin: EdgeInsets.only(top: 24),
              padding: EdgeInsets.symmetric(horizontal: 27),
              height: 33,
              width: 321,
              decoration: BoxDecoration(
                color: Color(0xff21C8BE),
                borderRadius: BorderRadius.circular(10.0)),
                child: Center(child: Text("Continue with Phone",style: TextStyle(color: Color(0xffFFFFFF),fontSize: 14,fontWeight: FontWeight.bold,),textAlign:TextAlign.center ,)),
              ),
              SizedBox(height: 15,),
              Container(
              padding: EdgeInsets.symmetric(horizontal: 27),
              height: 33,
              width: 321,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xff000000)),
                borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 52),
                      child:Image(image: AssetImage("assets/googleIcon.png"),height: 14,width: 14,),),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("Continue with Google",style: TextStyle(color: Color(0xff000000),fontSize: 14,fontWeight: FontWeight.bold,),textAlign:TextAlign.center ,)), 
                  ],
                ),
              ),
              SizedBox(height: 29,),
              Text("Cancel",style:TextStyle(fontSize: 14,color: Color(0xff707070)) ,textAlign: TextAlign.center,)
          ],
        ) ,),
    );
  }
  );
}
}