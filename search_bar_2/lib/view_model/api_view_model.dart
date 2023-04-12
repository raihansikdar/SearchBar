import 'package:dio/dio.dart';
import 'package:get/get.dart';
//import 'package:http/http.dart' as http;
import 'package:search_bar_2/model/search_model.dart';

class ApiViewModel extends GetxController with StateMixin<List<SearchModel>> {
  final RxList<SearchModel> _dataList = RxList();
  final RxList<SearchModel> filteredList = RxList();
  final dio = Dio();
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  // void fetchData() async {
  //   final response = await http.get(
  //     Uri.parse('https://jsonplaceholder.typicode.com/users'),
  //   );

  void fetchData() async {
    final response =
        await dio.get("https://jsonplaceholder.typicode.com/users");

    //log("response ===${response.data}");
    
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data;

      final jsonListData =
          jsonResponse.map((apiData) => SearchModel.fromJson(apiData)).toList();

      _dataList.value = jsonListData;
      filteredList.value = _dataList;

      if (filteredList.isEmpty) {
        change(null, status: RxStatus.empty());
      } else {
        change(filteredList, status: RxStatus.success());
      }
    } else {
      change(null, status: RxStatus.error('errorCode: ${response.statusCode}'));
    }
  }

  void searchData(String searchData) {
    if (searchData.isEmpty) {
      filteredList.value = _dataList;
      change(filteredList, status: RxStatus.success());
    } else if (filteredList.isEmpty) {
      change([], status: RxStatus.empty());
    } else {
      filteredList.value = _dataList.where((apiData) {
        return apiData.name!.toLowerCase().contains(searchData.toLowerCase());
      }).toList();

      change(filteredList, status: RxStatus.success());
    }
  }
}
