import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetStatus> {
  InternetCubit() : super(InternetStatus(ConnectivityStatus.disconnected));

  void checkConnectivity() async {
    var conntivityRestult = await Connectivity().checkConnectivity();
    _updateConnectivityStatus(conntivityRestult);
  }

  void _updateConnectivityStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      log("inside the bloc code state changed to disconnected");
      emit(InternetStatus(ConnectivityStatus.disconnected));
    } else {
      log("inside the bloc code state changed to connected");

      emit(InternetStatus(ConnectivityStatus.connected));
    }
  }

  late StreamSubscription<ConnectivityResult?> _subscription;

  void trackChanges() {
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      _updateConnectivityStatus(result);
    });
  }
}
