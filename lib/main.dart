import 'package:dtiapp/calculate_screen.dart';
import 'package:dtiapp/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'DB',
        primaryColor: kPrimaryColor,
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontSize: 24
          ),
          subtitle1: TextStyle(
            fontSize: 18
          )
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Positioned(top: 100, child: dashboardImage(size)),
              Positioned(bottom: 80, child: Container(
                width: size.width * 0.8,
                height: 50,
                child: RaisedButton(
                  color: kPrimaryColor,
                  elevation: 4,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CalculateDTI(title: 'คำนวณอัตราหนี้สินต่อรายได้',)));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.scatter_plot,color: kPrimaryFontColor,),
                      SizedBox(width: 10),
                      Text('START CALCULATE',style: TextStyle(fontSize: 28, color: kPrimaryFontColor),)
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget dashboardText() {
    return Column(
              children: [
                Text('อัตราหนี้สินต่อรายได้'),
                SizedBox(height: 10,),
                Text(
                  'DEPT TO INCOME RATIO',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 36,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text('จิรายุ อินทวงษ์  59342110304-7'),
              ],
            );
  }

  Widget dashboardImage(Size size) => Column(
    children: [
      Container(width: size.width * 0.9, child: Image.asset('assets/image_credit_dashboard.jpg')),
      SizedBox(height: 20),
      dashboardText()
    ],
  );
}
