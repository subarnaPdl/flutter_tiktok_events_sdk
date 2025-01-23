import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok_events_sdk/models/config/tiktok_android_options.dart';
import 'package:tiktok_events_sdk/models/config/tiktok_ios_options.dart';
import 'package:tiktok_events_sdk/models/tiktok_identifier.dart';
import 'package:tiktok_events_sdk/models/tiktok_log_level.dart';
import 'package:tiktok_events_sdk/tiktok_events_sdk.dart';
import 'package:tiktok_events_sdk/tiktok_events_sdk_platform_interface.dart';
import 'package:tiktok_events_sdk/tiktok_events_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTiktokEventsSdkPlatform with MockPlatformInterfaceMixin implements TiktokEventsSdkPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> identify({required TikTokIdentifier identifier}) {
    // TODO: implement identify
    throw UnimplementedError();
  }

  @override
  Future<void> initSdk(
      {required String androidAppId,
      required String tikTokAndroidId,
      required String iosAppId,
      required String tiktokIosId,
      bool isDebugMode = false,
      TikTokAndroidOptions androidOptions = const TikTokAndroidOptions(),
      TikTokIosOptions iosOptions = const TikTokIosOptions(),
      TikTokLogLevel logLevel = TikTokLogLevel.info}) {
    // TODO: implement initSdk
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}

void main() {
  final TiktokEventsSdkPlatform initialPlatform = TiktokEventsSdkPlatform.instance;

  test('$MethodChannelTiktokEventsSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTiktokEventsSdk>());
  });

  test('getPlatformVersion', () async {
    TiktokEventsSdk tiktokEventsSdkPlugin = TiktokEventsSdk();
    MockTiktokEventsSdkPlatform fakePlatform = MockTiktokEventsSdkPlatform();
    TiktokEventsSdkPlatform.instance = fakePlatform;

    // expect(await tiktokEventsSdkPlugin.getPlatformVersion(), '42');
  });
}
