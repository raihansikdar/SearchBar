import 'package:flutter/material.dart';
import 'package:search_bar_2/view_model/api_view_model.dart';
import 'package:get/get.dart';

import '../view_model/debounce.dart';

class HomePage extends GetView<ApiViewModel> {
  HomePage({super.key});

  final _debouncer = Debouncer(milliseconds: 1000);
  final ApiViewModel apiViewModel = Get.put(ApiViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            _debouncer.run(() {
              apiViewModel.searchData(value);
            });
          },
          decoration: const InputDecoration(
            icon: Icon(Icons.search),
            hintText: "Search",
            border: InputBorder.none,
          ),
        ),
      ),
      body: apiViewModel.obx(
        (state) => ListView.builder(
          itemCount: apiViewModel.filteredList.length,
          itemBuilder: (context, index) {
            final searchIndex = apiViewModel.filteredList[index];
            return ListTile(
              title: Text(searchIndex.name ?? ''),
              subtitle: Text(searchIndex.email ?? ''),
            );
          },
        ),
        onLoading: const Center(
          child: CircularProgressIndicator(),
        ),
        onEmpty: const Center(
          child: Text(
            "No result found",
            style: TextStyle(
              color: Colors.amber,
              fontSize: 22.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        onError: (error) => Text(error ?? ''),
      ),
    );
  }
}
