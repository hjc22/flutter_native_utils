import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:native_utils/native_utils.dart';

void main() {
  const MethodChannel channel = MethodChannel('native_utils');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return true;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await NativeUtils.cancelFullScreen(), true);
  });
}
