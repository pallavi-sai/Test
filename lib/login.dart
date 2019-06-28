import 'package:camaron/dashboard.dart';
import 'package:camaron/forgot_password.dart';
import 'package:camaron/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:validate/validate.dart';
import 'state_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//import 'face.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();

}


class _LoginData {
  String email = '';
  String password = '';
}


class _LoginScreenState extends State<LoginScreen> {
 FirebaseAuth _auth = FirebaseAuth.instance;
 bool isLogged = false;

 FirebaseUser myUser;

 Future<FirebaseUser> _loginwithFacebook() async {
   var facebookLogin = new FacebookLogin();
   var result = await facebookLogin.logInWithReadPermissions(['email']);

   debugPrint(result.status.toString());


   if(result.status== FacebookLoginStatus.loggedIn){
     FirebaseUser user = await _auth.signInWithFacebook(accessToken: result.accessToken.token);
     return user;
   }
    return null;
 }
  void _logIn(){
   _loginwithFacebook().then((response){
     if(response != null){
       myUser = response;
     }
   });
  }
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _LoginData _data = new _LoginData();

  String _validateEmail(String value) {
    // If empty value, the isEmail function throw a error.
    // So I changed this function with try and catch.
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'The E-mail Address must be a valid email address.';
    }

    return null;
  }

  String _validatePassword(String value) {
    if (value.length == 0) {
      return "Password is Required";
    } else if (value.length <= 8) {
      return "Password Should be equl or more than 8.";
    }

    return null;
  }
  String validatePasswordMatching(String value) {

    if (value.length == 0) {
      return "Password is Required";
    } else if (value != _validatePassword) {
      return 'Password is not matching';
    }
    return null;
  }



  void submit() {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      print('Printing the login data.');
      print('Email: ${_data.email}');
      print('Password: ${_data.password}');
    }
  }


  //@override
  Widget build(BuildContext context) {
    //final Size  ScreenSize = MediaQuery.of(context).size;
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    return new Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: new Text('ROBIC RUFARM'),
      ),
      body: new Container(
          //width: ScreenUtil.getInstance().setWidth(200),
         // height: ScreenUtil.getInstance().setWidth(200),
          padding: new EdgeInsets.all(10.0),
          child: new Form(
            key: this._formKey,
            child: new ListView(
              children: <Widget>[

                Column(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil.getInstance().setWidth(300),
                       height: ScreenUtil.getInstance().setWidth(350),
                        child: Image.asset('android/image/qwer.png')),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: new Text(
                        'CAMARON',
                        style: new TextStyle(
                          color: Colors.lightGreen,fontSize: 30.0,
                        ),textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                new SizedBox(height: 20.0),
                new TextFormField(

                    keyboardType: TextInputType.emailAddress,
                    // Use email input type for emails.
                    decoration: new InputDecoration(
                      hintText: 'you@example.com',
                      labelText: 'E-mail Address',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                    ),

                    validator: this._validateEmail,
                    onSaved: (String value) {
                      this._data.email = value;
                    }
                ),
                new SizedBox(height: 10.0),
                new TextFormField(

                    obscureText: true, // Use secure text for passwords.
                    decoration: new InputDecoration(
                      hintText: 'Password',
                      labelText: 'Enter your password',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                    ),
                    validator: this._validatePassword,
                    onSaved: (String value) {
                      this._data.password = value;
                    }
                ),
                   new Container(
                    child: new RaisedButton(
                      child: new Text(
                        'Login',
                        style: new TextStyle(
                          color: Colors.white,
                        ),textAlign: TextAlign.center,
                      ),
                      onPressed: () =>Navigator.of(context).push(MaterialPageRoute<Null>(
                          builder: (BuildContext context) {
                            return new Dashboard();
                          })),
                      color: Colors.green,
                      padding: EdgeInsets.fromLTRB(50, 15, 50, 15),

                    ),
                    margin: new EdgeInsets.only(
                        top: 30.0
                    ),
                  ),


                ButtonTheme.bar( // make buttons use the appropriate styles for cards
                  child: ButtonBar(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 160,0),
                        child: FlatButton(
                          child: new Text("Forgot Password",style: new TextStyle(color: Colors.green),textAlign: TextAlign.left),
                                   onPressed: (){
                                 Navigator.of(context).push(MaterialPageRoute<Null>(builder: (BuildContext context){
                                   return new ForgotPassword();
                                 }));
                                   },
//                          onPressed:() async {var response = await  ;
//                          setState(() {
//                            this._data.email = response;
//                          });
//                          if (_formKey.currentState.validate()) {
//                            _formKey.currentState.save();
//                            try {
//                              await widget._firebaseAuth.sendPasswordResetEmail(_data.email);
//                            } catch (e) {
//                              print(e);
//                            }
//                          }},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: FlatButton(
                          child: new Text("Signup",style: new TextStyle(color: Colors.green),textAlign: TextAlign.center,),
                          onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute<Null>(builder: (BuildContext context){
                                      return new SignupPage();
                                    }));
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                new Container(
                  child: new FlatButton(
                      onPressed: null,
                      child: new Column(
                          children: <Widget>[
                            Text("or",textAlign: TextAlign.center),
                            new SizedBox(height: 10.0),
                            Text("Login/SignIn with",textAlign: TextAlign.center,)
                          ]
                      )
                  ),
                ),

                new SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child: new FlatButton(
                          onPressed: () => StateWidget.of(context).signInWithGoogle(),
                          child: new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Image.asset(
                                'android/image/Google.png',
                                height: 40.0,
                              ),

                            ],
                          )
                      ),
                    ),
                    new Container(
                      child: new FlatButton(
//                        onPressed: (){},
                          onPressed: ()=> _logIn(),
                          child: new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Image.asset(
                                'android/image/facebookk.png',
                                height: 40.0,
                              ),
                            ],
                          )
                      ),

                    ),
                  ],
                ),

              ],
            ),
          )
      ),
    );

  }

}
