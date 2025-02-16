import 'package:bloc/bloc.dart';
import 'package:safetrack/presentation/bloc/features/announcement/announcement_event.dart';
import 'package:safetrack/presentation/bloc/features/announcement/announcement_state.dart';
import 'package:safetrack/services/feature_services.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  final FeatureServices featureServices;
  AnnouncementBloc({required this.featureServices})
      : super(AnnouncementInitial()) {
    on<FetchAnnouncementEvent>(fetchAnnouncementEvent);
  }
  Future<void> fetchAnnouncementEvent(
      FetchAnnouncementEvent event, Emitter<AnnouncementState> emit) async {
    emit(AnnouncementLoading());
    try {
      final announcement = await featureServices.fetchAnnouncement();
      emit(AnnouncementSuccess(announcement: announcement));
    } catch (e) {
      emit(AnnouncementFailed(errorMessage: e.toString()));
    }
  }
}
