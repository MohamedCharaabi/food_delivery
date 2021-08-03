import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode _emailNumberFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKeyLogin;

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    // _emailController.text = Provider.of<AuthProvider>(context, listen: false).getUserNumber() ?? '';
    // _passwordController.text = Provider.of<AuthProvider>(context, listen: false).getUserPassword() ?? '';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ResponsiveHelper.isDesktop(context) ? PreferredSize(child: MainAppBar(), preferredSize: Size.fromHeight(80)) : null,
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(15),
            physics: BouncingScrollPhysics(),
            child: Center(
              child: SizedBox(
                width: 1170,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, children: []),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
