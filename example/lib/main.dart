// Copyright 2017 Michael Goderbauer. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:contact_picker/contact_picker.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ContactPicker _contactPicker = new ContactPicker();
  Contact _contact;

  @override
  Widget build(BuildContext context) => new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: const Text('Plugin example app'),
          ),
          body: new Center(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new MaterialButton(
                  color: Colors.blue,
                  child: const Text("CLICK ME"),
                  onPressed: () async {
                    final Contact contact =
                        await _contactPicker.selectContact();
                    setState(() {
                      _contact = contact;
                    });
                  },
                ),
                new Text(
                  _contact == null
                      ? 'No contact selected.'
                      : _contact.toString(),
                ),
              ],
            ),
          ),
        ),
      );
}
