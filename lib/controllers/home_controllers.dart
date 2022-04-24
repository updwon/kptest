import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../fetch_data/connection_to_api.dart';

class HomeController extends GetxController {
  ConnectionToApi _apiProvider = ConnectionToApi();

  var myList = [].obs;
  var showList = [].obs;
  var isLoading = false.obs;
  var currentPage = 0;
  var pageSize = 5;
  late BuildContext context;

  LoadData(bool isReset) {
    print("load data");

    if(isReset){
      showList.clear();
    }

    var tempCount = 0;

    for (int i = currentPage * pageSize; i < myList.length; i++) {
      if (tempCount == pageSize) {
        break;
      }

      showList.add(myList[i]);
      tempCount++;
    }

    showList.refresh();

    update();
  }

  GetData() {

    isLoading = RxBool(true);

    _apiProvider.context = context;

    _apiProvider.fetchProducts().then((response) {

      myList = RxList(List.of(jsonDecode(response.toString())));

      print(myList.length);

      LoadData(true);

      isLoading = RxBool(false);

      update();

    }, onError: (err) {    isLoading = RxBool(false);

    print(err.toString());
    });
  }
}
