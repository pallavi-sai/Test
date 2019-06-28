import 'package:flutter/material.dart';
import 'package:validate/validate.dart';

void main() => runApp(new MaterialApp(
  title: 'Forms in Flutter',
  home: new ForgotPassword(),
));

class  ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ForgotPassword();
}

class _ForgotPasswordData {
  String email = '';
}

class _ForgotPassword extends State< ForgotPassword> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _ForgotPasswordData _data = new _ForgotPasswordData();

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



  void submit() {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.
      print('Email: ${_data.email}');
    }
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: new Text(' Forgot Password'),
      ),
      body: new Container(
          decoration: BoxDecoration(

            color: Colors.grey[200],

          ),
          padding: new EdgeInsets.fromLTRB(0,60.0,0,0),
          child: new Form(
            key: this._formKey,
            child: new ListView(
              children: <Widget>[
            new Container(
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              child: new FlatButton(
                child: new Text(
                  'Please Enter Your Email',
                  style: new TextStyle(
                      color: Colors.black54,fontSize: 25.0
                  ),
                ),
                onPressed: null,
              ),
              margin: new EdgeInsets.only(
                  top: 20.0
              ),
            ),
              new SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  child: new TextFormField(
                      keyboardType: TextInputType.emailAddress, // Use email input type for emails.
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
                ),
                new Container(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0) ,
                  child: new RaisedButton(
                    child: new Text(
                      'Reset Password',
                      style: new TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: this.submit,
                    color: Colors.green,
                  ),
                  margin: new EdgeInsets.only(
                      top: 40.0
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}