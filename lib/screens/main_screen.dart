import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kptest/controllers/home_controllers.dart';
import 'package:kptest/screens/detail_screen.dart';

class Main_Screen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(context) {
    controller.context = context;
    controller.GetData();

    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(child: GetBuilder<HomeController>(
          builder: (controller) {
            return NotificationListener<ScrollEndNotification>(
                onNotification: (scrollEnd) {
                  // Manual pagination
                  final metrics = scrollEnd.metrics;
                  if (metrics.atEdge) {
                    bool isTop = metrics.pixels == 0;

                    // check if user scroll position on the botoom of list
                    if (!isTop) {
                      print('At the bottom');

                      controller.currentPage = controller.currentPage + 1;
                      controller.LoadData(false);
                    }
                  }
                  return true;
                },
                child: controller.isLoading == true
                    ? Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : controller.showList.isEmpty
                        ? Container(
                            child: Center(
                              child: Text("No Data Available"),
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) => InkWell(
                                child: Container(
                                  constraints: BoxConstraints(maxHeight: 250),
                                  margin: EdgeInsets.only(
                                      left: Get.size.width * .1,
                                      right: Get.size.width * .1,
                                      top: 15,
                                      bottom: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Wrap(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                          child: Row(
                                            children: [
                                              Container(
                                                constraints: BoxConstraints(
                                                    maxWidth: 150,
                                                    maxHeight: 150),
                                                width: Get.size.width * .3,
                                                height: Get.size.width * .3,
                                                child: Stack(
                                                  children: [
                                                    Image.network(
                                                      controller.showList[index]
                                                          ['image'],
                                                      fit: BoxFit.contain,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return Container();
                                                      },
                                                    ),
                                                    Positioned(
                                                        top: 0,
                                                        child: Container(
                                                          child: Text(
                                                            "\$ " +
                                                                controller
                                                                    .showList[
                                                                        index][
                                                                        'price']
                                                                    .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20,
                                                                shadows: [
                                                                  Shadow(
                                                                    offset:
                                                                        Offset(
                                                                            0.0,
                                                                            0.0),
                                                                    blurRadius:
                                                                        2.0,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  Shadow(
                                                                    offset:
                                                                        Offset(
                                                                            0.0,
                                                                            0.0),
                                                                    blurRadius:
                                                                        5.0,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ]),
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                  child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        controller
                                                                .showList[index]
                                                            ['title'],
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      margin: EdgeInsets.only(
                                                          top: 10),
                                                      child: Text(
                                                        controller
                                                                .showList[index]
                                                            ['description'],
                                                        style: TextStyle(),
                                                        maxLines: 4,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 10),
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: RichText(
                                                        text:
                                                            TextSpan(children: [
                                                          WidgetSpan(
                                                            child: Icon(
                                                                Icons.star,
                                                                size: 14),
                                                          ),
                                                          TextSpan(
                                                              text: controller
                                                                  .showList[
                                                                      index]
                                                                      ['rating']
                                                                      ['rate']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                        ]),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () => Get.to(() => Detail_Screen(),
                                    arguments: controller.showList[index])),
                            itemCount: controller.showList.length));
          },
        )),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh), onPressed: () => controller.GetData()));
  }
}
