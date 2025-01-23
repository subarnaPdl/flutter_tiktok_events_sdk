part of '../tiktok_events_sdk.dart';

class TikTokException implements Exception {
  final String message;
  final dynamic cause;

  TikTokException(this.message, [this.cause]);

  @override
  String toString() {
    return 'TikTokException: $message ${cause != null ? '\nCause: $cause' : ''}';
  }
}
