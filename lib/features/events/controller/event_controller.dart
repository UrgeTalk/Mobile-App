import 'package:get/state_manager.dart';
import 'package:urge/common/helpers/utils.dart';
import 'package:urge/common/network/base_controller.dart';
import 'package:urge/features/events/model/event_model.dart';
import 'package:urge/features/events/services/event_service.dart';

class EventController extends GetxController with BaseController {
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

  void getAllEvents() {
    isListLoading(true);
    _eventService.getAllEvents().then((value) {
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

  void getSavedEventItems() {
    isListLoading(true);
    _eventService.getSavedItems().then((value) {
      print(value['data']);
      try {
        if (value['message'] == "Ok") {
          var trans = List<Event>.from(
              (value['data']['events']).map((x) => Event.fromMap(x)));
          savedEvent.value = trans;
          print('is this real?');
          print(savedEvent.length);
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


  void saveEventItem(Event model) {
    isLoading(true);
    _eventService.saveEvent(model.id).then((value) {
      if (value['message'] == "success") {
        showSnackBar(content: "Event Successfully Saved!");
      }
    }).catchError((error) {
      isListLoading(false);
      handleError(error);
    });
  }
    void registerEvent(Event model) {
    isLoading(true);
    _eventService.registerEvent(model.id).then((value) {
      if (value['message'] == "Event registration successful") {
        showSnackBar(content: "Registration Successful!");
      }
    }).catchError((error) {
      isListLoading(false);
      handleError(error);
    });
  }


  void getAllRegisteredEvents() {
    isListLoading(true);
    _eventService.getRegisteredEvents().then((value) {
      print(value['data']);
      print('Here now..');
      try {
        if (value['message'] == "success") {
          var transList = List<Event>.from(
              (value['data']['event']).map((x) => Event.fromMap(x)));
          registeredList.value = transList;
          print(registeredList.length);
          print('Here are some registered events');
          isListLoading(false);
        }
        // if (value != null && value['message'] == "success") {
        //   var data = value['data'];
        //   if (data != null && data is List) {
        //     var transList =
        //     List<Event>.from(data.map((x) => Event.fromMap(x)));
        //     registeredList.value = transList;
        //     print('Here are some registered events:');
        //     print(registeredList.length);
        //   } else {
        //     print('No events data available.');
        //   }
        // }

      } catch (error) {
        print(error);
      }
    }).catchError((error) {
      isListLoading(false);
      handleError(error);
    });
  }
}
