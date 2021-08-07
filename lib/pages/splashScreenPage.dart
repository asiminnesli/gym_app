import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gym_app/pages/openingPage.dart';
import 'package:gym_app/utils/uiHelper.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () async {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OpeningPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: UiHelper().bgGradient()),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 55, horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: .5,
                              color: Theme.of(context).primaryColor)),
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 30, right: 30, top: 5, bottom: 5),
                        child: Text(
                          "FITNESS APP",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                child: Stack(
                  children: [
                    Positioned(
                      top: 100,
                      left: MediaQuery.of(context).size.width * 0.5 - 25,
                      child: SpinKitRotatingCircle(
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ),
                    Positioned(
                      top: 75,
                      left: MediaQuery.of(context).size.width * 0.5 - 50,
                      child: Container(
                        child: SpinKitRing(
                          color: Colors.white,
                          size: 100.0,
                        ),
                      ),
                    ),
                    Center(
                      child: Text("Loading App",
                          style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              )),
        ],
      ),
    ));
  }
}
