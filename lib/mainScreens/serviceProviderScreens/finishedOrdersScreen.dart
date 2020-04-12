import 'package:flutter/material.dart';
import '../serviceProviderScreens/removeOrderScreen.dart';
import '../../widgets/orderCard.dart';
import '../../providers/ordersProvider.dart';
import 'package:provider/provider.dart';

class FinishedOrdersScreen extends StatelessWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'finishedOrdersScreen';

  Future<void> onRefresh(BuildContext context) async {
    await Provider.of<OrdersProvider>(context, listen: false)
        .fetchAdvertiserInitOrders(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Consumer<OrdersProvider>(
        builder: (context, finishedOrders, child) =>
            finishedOrders.finishedOrders.length == 0
                ? Center(
                    child: Text(
                      'لم تقم بانهاء اى طلبات',
                      style: TextStyle(
                        fontFamily: 'beINNormal',
                        color: Colors.grey,
                        fontSize: 16.0,
                      ),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () => onRefresh(context),
                    backgroundColor: Color.fromRGBO(104, 57, 120, 10),
                    color: Color.fromRGBO(235, 218, 241, 10),
                    child: ListView.builder(
                      itemCount: finishedOrders.finishedOrders.length + 1,
                      itemBuilder: (context, index) {
                        return index != finishedOrders.finishedOrders.length
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => RemovingOrderScreen(
                                        orderId: finishedOrders
                                            .finishedOrders[index].id,
                                        userImage: finishedOrders
                                            .finishedOrders[index].userImage,
                                        services: finishedOrders
                                            .finishedOrders[index].services,
                                      ),
                                    ),
                                  );
                                },
                                child: OrderCard(
                                  userName: finishedOrders
                                      .finishedOrders[index].username,
                                  date: finishedOrders
                                      .finishedOrders[index].createdAt.date
                                      .split(' ')[0],
                                  time: finishedOrders
                                      .finishedOrders[index].createdAt.date
                                      .split(' ')[1]
                                      .split('.')[0],
                                  serviceName: finishedOrders
                                      .finishedOrders[index]
                                      .services[0]
                                      .userService
                                      .type,
                                  image: finishedOrders
                                      .finishedOrders[index].userImage,
                                ),
                              )
                            : SizedBox(
                                height: 70.0,
                              );
                      },
                    ),
                  ),
      ),
    );
  }
}
