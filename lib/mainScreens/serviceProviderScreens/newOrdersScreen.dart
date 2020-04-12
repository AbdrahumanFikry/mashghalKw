import 'package:flutter/material.dart';
import '../serviceProviderScreens/newOrderDetailsScreen.dart';
import '../../widgets/orderCard.dart';
import '../../providers/ordersProvider.dart';
import 'package:provider/provider.dart';

class NewOrdersScreen extends StatelessWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'newOrdersScreen';

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
        builder: (context, initOrders, child) => initOrders.initOrders.length ==
                0
            ? Center(
                child: Text(
                  'ليس لديك اى طلبات',
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
                  itemCount: initOrders.initOrders.length + 1,
                  itemBuilder: (context, index) {
                    return index != initOrders.initOrders.length
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => NewOrderDetailsScreen(
                                    orderId: initOrders
                                        .initOrders[index].id,
                                    userImage: initOrders.initOrders[index].userImage,
                                    services: initOrders
                                        .initOrders[index].services,
                                  ),
                                ),
                              );
                            },
                            child: OrderCard(
                              userName: initOrders
                                  .initOrders[index].username,
                              date: initOrders
                                  .initOrders[index].createdAt.date
                                  .split(' ')[0],
                              time: initOrders
                                  .initOrders[index].createdAt.date
                                  .split(' ')[1]
                                  .split('.')[0],
                              serviceName: initOrders.initOrders[index].services[0].userService.type,
                              image: initOrders
                                  .initOrders[index].userImage,
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
