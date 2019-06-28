import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:validate/validate.dart';
import 'package:intl/intl.dart';

void main() => runApp(new MaterialApp(
  title: 'Forms in Flutter',
  home: new SignupPage(),
));

class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SignuppageState();
}

class _SignupData {
  String firstname = '';
  String lastname = '';
  String email = '';
  String password = '';
}
class Contact{
  String phone ='';
}
Contact newContact = new Contact();
var passKey = GlobalKey<FormFieldState>();

class _SignuppageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _SignupData _data = new _SignupData();

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

//  String _validatepassword(String value) {
//    if (value.length < 8) {
//      return 'The Password must be at least 8 characters.';
//    }
//
//    return null;
//  }

  bool isValidPhoneNumber(String input) {
    final RegExp regex = new RegExp(r'^[()\d -]{1,15}$');
    if(input.length != 10) {
      return regex.hasMatch(input ='Number must contain 10 digits');
    }
    return regex.hasMatch(input);
  }

  bool isValidname(String input) {
    final RegExp regex = new RegExp(r'^[a-zA-Z\ ]{1,35}$');
    return regex.hasMatch(input);
  }

  bool isValidDob(String dob) {
    if (dob.isEmpty) return true;
    var d = convertToDate(dob);
    return d != null && d.isBefore(new DateTime.now());
  }



  void submit() {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      print('Printing the SignUp data.');
      print('Email: ${_data.email}');
      print('Password: ${_data.password}');
      print('Re-enter Password: ${_data.password}');
    }
  }


  final TextEditingController _controller = new TextEditingController();
  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1950 && initialDate.isBefore(now) ? initialDate : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1950),
        lastDate: new DateTime.now());

    if (result == null) return;

    setState(() {
      _controller.text = new DateFormat.yMMMd().format(result);
    });
  }

  DateTime convertToDate(String input) {
    try
    {
      var d = new DateFormat.yMMMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;


    return new Scaffold(
      appBar: new AppBar(
        backgroundColor:Colors.green,
        title: new Text('Sign up'),
      ),
      body: new Container(

          padding: new EdgeInsets.all(20.0),
          child: new Form(
            key: this._formKey,
            child: new ListView(
              children: <Widget>[
                new SizedBox(
                height:12.0
            ),
                new TextFormField(
                    decoration: new InputDecoration(
                        hintText: 'Enter your name',
                        labelText: 'Name',
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    ),
                    keyboardType: TextInputType.text,
                    inputFormatters:[
                      new WhitelistingTextInputFormatter(
                          new RegExp(r'^[a-zA-Z\ ]{1,35}$'))
                    ],
                    validator: (value) => isValidname(value)
                        ? null
                        : 'Username cannot contains Numbers'
                ),
                new SizedBox(
                    height:12.0
                ),
                new Row(children: <Widget>[
                  new Expanded(
                      child: new TextFormField(
                        decoration: new InputDecoration(
                          hintText: 'Enter your Date Of Birth',
                          labelText: 'Date Of Birth',
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                        ),
                        controller: _controller,
                        keyboardType: TextInputType.datetime,
                        validator: (val) => isValidDob(val) ? null : 'Not a Valid Date',
                      )),
                  new IconButton(
                    icon:new Icon(Icons.calendar_today),
                    tooltip: 'Choose Date',
                    onPressed: (() {
                      _chooseDate(context, _controller.text);

                    }),
                  )
                ]),
                new SizedBox(
                    height:12.0
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Enter your Number',
                      labelText: 'Contact',
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    new WhitelistingTextInputFormatter(
                        new RegExp(r'^[()\d -]{1,15}$')),
                  ],
                  validator: (value) => isValidPhoneNumber(value)
                      ? null
                      : 'Number Must Contain 10 Digits',
                ),
                new SizedBox(
                    height:12.0
                ),
                new TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    // Use email input type for emails.
                    decoration: new InputDecoration(
                        hintText: 'you@example.com',
                        labelText: 'E-mail Address',
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    ),
                    validator: this._validateEmail,
                    onSaved: (String value) {
                      this._data.email = value;
                    }
                ),
                new SizedBox(
                    height:12.0
                ),
                new TextFormField(
                    key: passKey,
                    obscureText: true, // Use secure text for passwords.
                    decoration: new InputDecoration(
                        hintText: 'Password',
                        labelText: 'Enter your password',
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    ),
                    validator: (password)
                    {
                      var result = password.length < 8 ? "Password should contain atleast 8 characters"
                          : null;
                      return result;
                    }
                ),
                new SizedBox(
                    height:12.0
                ),
                new TextFormField(
                  obscureText: true,
                  decoration: new InputDecoration(
                      hintText: 'password',
                      labelText: 'Re-enter your password',
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                  ),
                  validator: (confirmation){
                    var password = passKey.currentState.value;
                    return equals(confirmation,password) ? null : "Both passwords must be matched";
                  },
                ),
                new SizedBox(
                    height:12.0
                ),
                new Container(
                  width: screenSize.width,
                  child: new RaisedButton(
                    child: new Text(
                      'Sign up',
                      style: new TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: this.submit,
                    color: Colors.green,
                  ),
                  margin: new EdgeInsets.only(
                      top: 20.0
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}