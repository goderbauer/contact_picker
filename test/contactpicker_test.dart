//import 'package:flutter/services.dart';
//import 'package:flutter_test/flutter_test.dart';

//void main() {
//  const MethodChannel channel = MethodChannel('contactpicker');
//
//  TestWidgetsFlutterBinding.ensureInitialized();
//
//  setUp(() {
//    channel.setMockMethodCallHandler((MethodCall methodCall) async {
//      return '42';
//    });
//  });
//
//  tearDown(() {
//    channel.setMockMethodCallHandler(null);
//  });
//
//  test('getPlatformVersion', () async {
//    expect(await ContactPicker.platformVersion, '42');
//  });
//}
