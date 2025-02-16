import 'package:safetrack/models/announcement.dart';

abstract class AnnouncementState {}

final class AnnouncementInitial extends AnnouncementState {}

class AnnouncementLoading extends AnnouncementState{}

class AnnouncementSuccess extends AnnouncementState{
  final List<Announcement> announcement;

  AnnouncementSuccess({required this.announcement});
}

class AnnouncementFailed extends AnnouncementState{
  final String errorMessage;

  AnnouncementFailed({required this.errorMessage});
}