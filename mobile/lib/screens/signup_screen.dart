import 'package:flutter/material.dart';

import '../resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';
import 'login_screen.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text);

    if (res != 'succes') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              )));
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
                  'Inregistreaza-te!',
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
                        controller: _usernameController,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.person, color: Colors.grey,),
                            label: Text('Username', style: TextStyle(
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
                            onTap: signUpUser,
                            child: _isLoading ? const Center(child: CircularProgressIndicator(
                              color: primaryColor,
                            ),) : const Center(child: Text('SIGN UP', style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white
                            ),)),
                          )
                      ),
                      SizedBox(height: 210,),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Ai deja cont?", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffec7d00)
                            ),),
                            GestureDetector(
                              child: Text("Conecteaza-te!", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xff3a2a05),

                              ),),
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
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




//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//       child: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               'assets/wallpaper.jpg',
//               fit: BoxFit.cover,
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 32),
//             width: double.infinity,
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Flexible(flex: 2, child: Container()),
//                   const Text(
//                     'Sign up',
//                     style: TextStyle(
//                       color: primaryColor,
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//
//                   const SizedBox(
//                     height: 64,
//                   ),
//                   //circularWidget
//                   const Stack(),
//                   TextFieldInput(
//                     hintText: 'Enter your email',
//                     textInputType: TextInputType.emailAddress,
//                     textEditingController: _emailController,
//                   ),
//                   const SizedBox(
//                     height: 24,
//                   ),
//                   TextFieldInput(
//                     hintText: 'Enter your username',
//                     textInputType: TextInputType.text,
//                     textEditingController: _usernameController,
//                   ),
//                   const SizedBox(
//                     height: 24,
//                   ),
//                   TextFieldInput(
//                     hintText: 'Enter your password',
//                     textInputType: TextInputType.text,
//                     isPass: true,
//                     textEditingController: _passwordController,
//                   ),
//                   const SizedBox(
//                     height: 24,
//                   ),
//
//                   InkWell(
//                     onTap: signUpUser,
//                     child: Container(
//                       width: double.infinity,
//                       alignment: Alignment.center,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       decoration: const ShapeDecoration(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(4),
//                             ),
//                           ),
//                           color: blueColor),
//                       child: _isLoading
//                           ? const Center(
//                               child: CircularProgressIndicator(
//                                 color: primaryColor,
//                               ),
//                             )
//                           : const Text('Log in'),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   Flexible(flex: 2, child: Container()),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 8,
//                         ),
//                         child: const Text("Already have an account?"),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).pushReplacement(
//                               MaterialPageRoute(
//                                   builder: (context) => const LoginScreen()));
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 8,
//                           ),
//                           child: const Text(
//                             "Log in ",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ]),
//           ),
//         ],
//       ),
//     ));
//   }
// }
