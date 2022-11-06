import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../domain/api/api_utils.dart';
import '../domain/model/slide_phone_model.dart';

class ToolGameProvider with ChangeNotifier {
  int? status;
  final api = APIUtils(Dio());
  List<SlidePhoneModel>? listSlidePhone=[];
  int percent = 1;

  void increment(int count) {
    percent = count;
    notifyListeners();
  }

  void checkStatus(int? statut) {
    status = statut;
    notifyListeners();
  }

  void getd() {
    api.getSlidePhone().then((value) {
      listSlidePhone = value;
    });
    // notifyListeners();
  }
}
