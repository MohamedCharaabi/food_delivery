import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/pages/Home.dart';
// import 'package:flutter_login_signup/src/signup.dart';
import 'package:food_delivery_flutter/pages/auth/signup1.dart';
import 'package:food_delivery_flutter/pages/home/home_template.dart';
import 'package:food_delivery_flutter/pages/widgets/bezierContainer.dart';
import 'package:food_delivery_flutter/services/firebase_services.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'Widget/bezierContainer.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  bool loading = false;
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
      child: TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: isPassword ? 'Password' : 'Email or phone',
              prefixIcon: isPassword ? Icon(Icons.lock) : Icon(Icons.email),
              fillColor: Color(0xfff3f3f4),
              filled: true)),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        setState(() {
          loading = true;
        });
        bool? login = await FirebaseService().signInWithEmailPassword(
            _emailController.text.trim(), _passwordController.text.trim());
        setState(() {
          loading = false;
        });
        if (login == true) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeTemplate()),
              (route) => false);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or', style: TextStyle(color: Colors.white)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton(bool facebook) {
    return InkWell(
      onTap: () async {
        facebook
            ? await FirebaseService().signInwithGoogle()
            : await FirebaseService().signInWithFacebook();
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(facebook ? 0xff1959a9 : 0xffaa3126),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text(facebook ? 'F' : 'G',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(facebook ? 0xff2872ba : 0xffe14a3f),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text(
                    facebook ? 'Log in with Facebook' : 'Log in with Gmail',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Food',
          style: TextStyle(
            // textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'Delivery',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            // TextSpan(
            //   text: 'rnz',
            //   style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            // ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email or phone", _emailController),
        _entryField("Password", _passwordController, isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/backgroundLogin.jpg'),
              colorFilter: new ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
              fit: BoxFit.cover)),
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: height * .2),
              _title(),
              SizedBox(height: 50),
              _emailPasswordWidget(),
              SizedBox(height: 20),
              !loading
                  ? _submitButton()
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.centerRight,
                child: Text('Forgot Password ?',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
              ),
              _divider(),
              _facebookButton(false),
              // SizedBox(height: 5),
              _facebookButton(true),
              SizedBox(height: height * .025),
              _createAccountLabel(),
            ],
          ),
        ),
      ),

      // child: Stack(
      //   children: <Widget>[
      //     // Positioned(
      //     //   top: -height * .15,
      //     //   right: -MediaQuery.of(context).size.width * .4,
      //     //   child: Container(
      //     //     decoration: BoxDecoration(
      //     //         image: DecorationImage(
      //     //             image: AssetImage('assets/images/backgroundLogin.jpg'))),
      //     //   ),
      //     // ),
      //     Container(
      //       color: Colors.transparent,
      //       padding: EdgeInsets.symmetric(horizontal: 20),
      //       child: SingleChildScrollView(
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: <Widget>[
      //             SizedBox(height: height * .2),
      //             _title(),
      //             SizedBox(height: 50),
      //             _emailPasswordWidget(),
      //             SizedBox(height: 20),
      //             _submitButton(),
      //             Container(
      //               padding: EdgeInsets.symmetric(vertical: 10),
      //               alignment: Alignment.centerRight,
      //               child: Text('Forgot Password ?',
      //                   style: TextStyle(
      //                       color: Colors.white,
      //                       fontSize: 14,
      //                       fontWeight: FontWeight.w500)),
      //             ),
      //             _divider(),
      //             _facebookButton(false),
      //             // SizedBox(height: 5),
      //             _facebookButton(true),
      //             SizedBox(height: height * .025),
      //             _createAccountLabel(),
      //           ],
      //         ),
      //       ),
      //     ),
      //     // Positioned(top: 40, left: 0, child: _backButton()),
      //   ],
      // ),
    ));
  }
}
