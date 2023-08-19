import 'package:get/state_manager.dart';
import 'package:urge/common/helpers/utils.dart';
import 'package:urge/common/network/base_controller.dart';
import 'package:urge/features/events/model/event_model.dart';
import 'package:urge/features/events/services/event_service.dart';

class AnonymousEventController extends GetxController with BaseController {
  final EventService _eventService = EventService();

  var isLoading = false.obs;
  var isListLoading = false.obs;
  var errorMessage = ''.obs;
  var eventList = <Event>[].obs;
  var newUpcomingList = <Event>[].obs;
  var upcomingList = <Event>[].obs;
  var registeredList = <Event>[].obs;
  var newEventList = <Event>[].obs;
  var emptyMessage = 'No record available'.obs;
  var savedEvent = <Event>[].obs;
  var newSavedEvent = <Event>[].obs;

  void getAllAnonymousEvents() {
    isListLoading(true);
    _eventService.getAllAnonymousEvents().then((value) {
      print(value['data']);
      print('Here now..');
      try {
        if (value['message'] == "success") {
          var trans =
          List<Event>.from((value['data']['past_events']).map((x) => Event.fromMap(x)));
          eventList.value = trans;
          print(eventList.length);
          var transList =
          List<Event>.from((value['data']['upcoming_events']).map((x) => Event.fromMap(x)));
          upcomingList.value = transList;
          print(upcomingList.length);
          print('Here are some events');
          isListLoading(false);
        }
      } catch (error) {
        print(error);
      }
    }).catchError((error) {
      isListLoading(false);
      handleError(error);
    });
  }

}