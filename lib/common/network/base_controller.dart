import 'package:urge/common/network/app_exception.dart';
import 'package:urge/common/network/dialog_help.dart';

class BaseController {
  void handleError(error) {
    if (error is BadRequestException) {
      var message = error.message;
      DialogHelper.showErrorDialog(description: message);
    } else if (error is FetchDataException) {
      var message = error.message;
      //  showSnackBar(content: message!);
      DialogHelper.showErrorDialog(description: message);
    } else if (error is ApiNotRespondingException) {
      DialogHelper.showErrorDialog(
          description: 'Oops! It took longer to respond.');
    } else if (error is UnAuthorizedException) {
      var message = error.message;
      DialogHelper.showErrorDialog(description: message);
    } else {
      DialogHelper.showErrorDialog(
        title: 'Error',
        description: "An error occurred, please try again",
      );
    }
  }

  String handleErrorMessage(e) {
    String errorMess = '';
    e is BadRequestException ||
            e is FetchDataException ||
            e is ApiNotRespondingException
        ? errorMess = e.message!
        : 'An error occurred';
    return errorMess;
  }

  showLoading([String? message]) {
    DialogHelper.showLoading(message);
  }

  hideLoading() {
    DialogHelper.hideLoading();
  }
}
