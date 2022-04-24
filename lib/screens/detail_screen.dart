import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/detail_controllers.dart';

class Detail_Screen extends StatelessWidget {
  final SecondScreenController controller = Get.put(SecondScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: Get.size.width * .5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Colors.white,
                      child: Image.network(
                        controller.data['image'],
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container();
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      "\$ " +
                          controller.data['price']
                              .toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                         ),
                    ),
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    controller.data['title'],
                    style: TextStyle(
                        color: Colors.black,

                        fontSize: 20),
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    controller.data['category'],
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    controller.data['description'],
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
