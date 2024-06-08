import 'package:flutter/material.dart';
import 'package:vetlink/screens/signup_screen.dart';

import '../resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == "success") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        ),
      ));
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff332301),
              Color(0xfff67408),
            ]),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 22),
            child: Text(
              'Bine ai venit\nConecteaza-te!',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 300.0),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white60,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 28.0, right:28.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.mail, color: Colors.grey,),
                        label: Text('Email', style: TextStyle(
                            fontWeight: FontWeight.bold,
                        color:Color(0xff332301)),)

                      ),
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.visibility_off, color: Colors.grey,),
                        label: Text('Parola', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:Color(0xff332301)),)
                      ),
                    ),
                    SizedBox(height: 50,),
                    Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff332301),
                            Color(0xfff67408),
                          ]
                        )
                      ),
                      child: InkWell(
                        onTap: loginUser,
                        child: _isLoading ? const Center(child: CircularProgressIndicator(
                          color: primaryColor,
                        ),) : const Center(child: Text('SIGN IN', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white
                        ),)),
                      )
                    ),
                    SizedBox(height: 250,),
                    Align(
                      alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Nu ai cont?", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffec7d00)
                            ),),
                            GestureDetector(
                              child: Text("Inregistreaza-te!", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xff3a2a05),

                              ),),
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const SignupScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                    )
                  ],
                ),
              ),

          ),
        )
      ],
    ));
  }
}
