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
    return new Contact.fromMap(result);
  }
}

/// Represents a contact selected by the user.
class Contact {
  Contact(
      {this.fullName,
      this.phoneNumbers,
      this.emails,
      this.addresses,
      this.ims});

  factory Contact.fromMap(Map<dynamic, dynamic> map) => new Contact(
        fullName: map['fullName'],
        phoneNumbers: List<PhoneNumber>.from((map['phones'])
            .map<PhoneNumber>((dynamic i) => PhoneNumber.fromMap(i))),
        emails: List<Email>.from(
            (map['emails']).map<Email>((dynamic i) => Email.fromMap(i))),
        addresses: List<Address>.from(
            (map['addresses']).map<Address>((dynamic i) => Address.fromMap(i))),
        ims: List<Im>.from((map['ims']).map<Im>((dynamic i) => Im.fromMap(i))),
      );

  /// The full name of the contact, e.g. "Dr. Daniel Higgens Jr.".
  final String fullName;

  /// The phone numbers of the contact.
  final List<PhoneNumber> phoneNumbers;

  /// The emails of the contact.
  final List<Email> emails;

  /// The addresses of the contact.
  final List<Address> addresses;

  /// The instant messengers of the contact
  final List<Im> ims;

  @override
  String toString() => '$fullName: $phoneNumbers $emails $addresses $ims';
}

/// Represents a phone number selected by the user.
class PhoneNumber {
  PhoneNumber({this.number, this.label});

  factory PhoneNumber.fromMap(Map<dynamic, dynamic> map) =>
      new PhoneNumber(number: map['phone'], label: map['label']);

  /// The formatted phone number, e.g. "+1 (555) 555-5555"
  final String number;

  /// The label associated with the phone number, e.g. "home" or "work".
  final String label;

  @override
  String toString() => '$number ($label)';
}

/// Represents a phone number selected by the user.
class Address {
  Address(
      {this.street,
      this.pobox,
      this.neighborhood,
      this.city,
      this.region,
      this.country,
      this.label});

  factory Address.fromMap(Map<dynamic, dynamic> map) => new Address(
      street: map['street'],
      pobox: map['pobox'],
      neighborhood: map['neighborhood'],
      city: map['city'],
      region: map['region'],
      country: map['country'],
      label: map['label']);

  /// The formatted phone number, e.g. "+1 (555) 555-5555"
  final String street;

  /// The formatted phone number, e.g. "+1 (555) 555-5555"
  final String pobox;

  /// The formatted phone number, e.g. "+1 (555) 555-5555"
  final String neighborhood;

  /// The formatted phone number, e.g. "+1 (555) 555-5555"
  final String city;

  /// The formatted phone number, e.g. "+1 (555) 555-5555"
  final String region;

  /// The formatted phone number, e.g. "+1 (555) 555-5555"
  final String country;

  /// The label associated with the phone number, e.g. "home" or "work".
  final String label;

  @override
  String toString() =>
      '$street $pobox $neighborhood $city $region $country ($label)';
}

/// Represents a email address
class Email {
  Email({this.email, this.label});

  factory Email.fromMap(Map<dynamic, dynamic> map) =>
      new Email(email: map['email'], label: map['label']);

  /// The raw email address
  final String email;

  /// The label associated with the email, e.g. "home" or "work".
  final String label;

  @override
  String toString() => '$email ($label)';
}

/// Represents a instant messaging endpoint
class Im {
  Im({this.value, this.label, this.protocol});

  factory Im.fromMap(Map<dynamic, dynamic> map) =>
      new Im(value: map['im'], label: map['label'], protocol: map['protocol']);

  /// The IM endpoint
  final String value;

  /// The label associated with the endpoint, e.g. "home" or "work".
  final String label;

  /// The IM protocol, e.g. Skype, Hangouts ...
  final String protocol;

  @override
  String toString() => '$value $protocol ($label)';
}
