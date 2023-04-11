import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_bar/controller/api_controller.dart';

class HomePage extends StatelessWidget {
    HomePage({super.key});

  final ApiController apiController = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            apiController.filterData(value);
          },
          decoration: const InputDecoration(
            icon: Icon(Icons.search),
            hintText: "Search",
            border: InputBorder.none,
          ),
        ),
      ),
      
      body: Obx(() {
        if (apiController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return apiController.filteredList.length ==0 ? const Center(
                child: Text("No result found",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w900,
                ),
                ),
                
              ): ListView.builder(
          itemCount: apiController.filteredList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(apiController.filteredList[index].name ?? ''),
              subtitle: Text(apiController.filteredList[index].email ?? ''),
            );
          },
        );
      }),
    );
  }
}
