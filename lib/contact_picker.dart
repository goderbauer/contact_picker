// Copyright 2017 Michael Goderbauer. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/services.dart';

/// Entry point for the ContactPicker plugin.
///
/// Call [selectContact] to bring up a dialog where the user can pick a contact
/// from his/her address book.
class ContactPicker {
  static const MethodChannel _channel = const MethodChannel('contact_picker');

  /// Brings up a dialog where the user can select a contact from his/her
  /// address book.
  ///
  /// Returns the [Contact] selected by the user, or `null` if the user canceled
  /// out of the dialog.
  Future<Contact> selectContact() async {
    final Map<dynamic, dynamic> result =
        await _channel.invokeMethod('selectContact');
    if (result == null) {
      return null;
    }
    return Contact.fromMap(result);
  }
}

/// Represents a contact selected by the user.
class Contact {
  Contact({this.fullName, this.phoneNumbers});

  factory Contact.fromMap(Map<dynamic, dynamic> map) => Contact(
      fullName: map['fullName'],
      phoneNumbers: map['phoneNumbers'].cast<String>());

  /// The full name of the contact, e.g. "Dr. Daniel Higgens Jr.".
  final String fullName;

  /// The formatted phone number, e.g. "+1 (555) 555-5555"
  final List<String> phoneNumbers;

  @override
  String toString() => '$fullName: $phoneNumbers';
}
