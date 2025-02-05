import 'dart:async';
import 'package:get/get.dart';

class TimerController extends GetxController {
  var start = 20.obs; 
  late Timer _timer;

  // Start the countdown timer
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (start.value == 0) {
        timer.cancel();
      } else {
        start.value--;
      }
    });
  }

  @override
  void onClose() {
    _timer.cancel(); 
    super.onClose();
  }
}
