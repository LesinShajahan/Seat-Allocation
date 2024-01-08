import 'package:flutter/material.dart';
import 'package:seat_allocation/view/Loginpage.dart';
import 'package:seat_allocation/view/loginpage_admin.dart';
import 'package:seat_allocation/view/loginpage_teacher.dart';
// import 'package:seat_allocation/view/lojnas.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 57, 85),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "F A L S",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                          },
                          child: Icon(Icons.person_2_rounded),
                          style: ButtonStyle(
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(30)),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => loginpage_teacher(),
                                ));
                          },
                          child: Icon(Icons.person_add_disabled_sharp),
                          style: ButtonStyle(
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(30)),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminLogin(),
                ));
          },
          label: Icon(Icons.admin_panel_settings_outlined)),
    );
  }
}
