import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:search_bar/model/search_model.dart';

class ApiController extends GetxController {
  var isLoading = true.obs;
  var dataList = <SearchModel>[].obs;
  var filteredList = <SearchModel>[].obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    isLoading(true);

    var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      dataList.value =
          jsonResponse.map((data) => SearchModel.fromJson(data)).toList();
      filteredList.value = dataList;
    } else {
      Get.snackbar("Error", "Failed to fetch data");
    }
    isLoading(false);
  }

  void filterData(String searchData) {
    if (searchData.isEmpty) {
      filteredList.value = dataList; 
    } else {
      filteredList.value = dataList
          .where(
              (apiData) => apiData.name!.toLowerCase().contains(searchData.toLowerCase()))
          .toList();
    }
  }
}
