import 'package:tiktok_events_sdk/models/config/tiktok_android_options.dart';
import 'package:tiktok_events_sdk/models/config/tiktok_ios_options.dart';
import 'package:tiktok_events_sdk/models/events/tt_base_event.dart';
import 'package:tiktok_events_sdk/models/tiktok_identifier.dart';
import 'package:tiktok_events_sdk/models/tiktok_log_level.dart';

import 'tiktok_events_sdk_platform_interface.dart';

class TiktokEventsSdk {
  Future<void> initSdk({
    required String androidAppId,
    required String tikTokAndroidId,
    required String iosAppId,
    required String tiktokIosId,
    bool isDebugMode = false,
    TikTokAndroidOptions androidOptions = const TikTokAndroidOptions(),
    TikTokIosOptions iosOptions = const TikTokIosOptions(),
    TikTokLogLevel logLevel = TikTokLogLevel.info,
  }) async {
    return TiktokEventsSdkPlatform.instance.initSdk(
      androidAppId: androidAppId,
      tikTokAndroidId: tikTokAndroidId,
      iosAppId: iosAppId,
      tiktokIosId: tiktokIosId,
      isDebugMode: isDebugMode,
      androidOptions: androidOptions,
      iosOptions: iosOptions,
      logLevel: logLevel,
    );
  }

  Future<void> identify({
    required TikTokIdentifier identifier,
  }) async {
    return TiktokEventsSdkPlatform.instance.identify(
      identifier: identifier,
    );
  }

  Future<void> logout() async {
    return TiktokEventsSdkPlatform.instance.logout();
  }

  Future<void> logEvent({
    required TTBaseEvent event,
  }) async {
    try {
      return TiktokEventsSdkPlatform.instance.logEvent(event: event);
    } catch (e) {}
  }
}
