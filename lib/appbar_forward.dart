//import 'dart:io';
import 'package:camaron/dashboard.dart';
import 'package:camaron/login.dart';
//import 'package:camaron/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:camaron/Contact.dart';
class AppBarBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint(MediaQuery
        .of(context)
        .size
        .height
        .toString());
    final title = 'Basic List';
    return MaterialApp(
        title: title,
        home: Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: true,
                backgroundColor: Colors.green,
                leading: IconButton(icon: Icon(Icons.arrow_back),
                    //alignment: Alignment(0,0.3),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute<Null>(
                          builder: (BuildContext context) {
                            return new Dashboard();
                          }
                      )

                      );
                    }
                )
            ),
            body: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.trending_up),
                    title: Text('Ph trend'),
                  ),
                  ListTile(
                    leading: Icon(Icons.keyboard_arrow_right),
                    title: Text('Dissolved O2 Trend'),
                  ),
                  ListTile(
                    leading: Icon(Icons.cloud),
                    title: Text('Temperature Trend'),
                  ),
                  ListTile(
                    leading: Icon(Icons.devices),
                    title: Text('About Device'),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('About Us'),
                    onTap: () {
                      launch('https://robicrufarm.com');
                    },
                  ),
                  ListTile(
                      leading: Icon(Icons.contact_phone),
                      title: Text('Contact Us'),

                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return new ContactUs();
                            }));
                      }
                  ),
                  ListTile(
                      leading: Icon(Icons.power_settings_new),
                      title: Text('Logout'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return new LoginScreen();
                            })
                        );
                      }
                  )
                  ]
            )
        )
    );
  }
}
class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contact Information'),
        ),
        body: new Container(
            child: Text(

              'CONTACT US''\n'
                  'MAIL : myrufarm@gmail.com''\n'
                  'PHONE NO: 08328684533''\n'
                  'OFFICIAL WESITE: https://robicrufarm.com',
              style: TextStyle(color: Colors.black),
              textScaleFactor: 1.5,
            )
        )
    );
  }
}