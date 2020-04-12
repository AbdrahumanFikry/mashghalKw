import 'package:flutter/material.dart';
import '../serviceProviderScreens/finishingOrderScreen.dart';
import '../../widgets/orderCard.dart';
import 'package:provider/provider.dart';
import '../../providers/ordersProvider.dart';

class ConfirmedOrdersScreen extends StatelessWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'confirmedOrdersScreen';

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
        builder: (context, paidOrders, child) => paidOrders.paidOrders.length ==
                0
            ? Center(
                child: Text(
                  'لم تقم بتأكيد اى طلبات',
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
                  itemCount: paidOrders.paidOrders.length + 1,
                  itemBuilder: (context, index) {
                    return index != paidOrders.paidOrders.length
                        ? GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => FinishingOrderScreen(
                                    id: paidOrders.paidOrders[index].id,
                                    userImage:
                                        paidOrders.paidOrders[index].userImage,
                                    services: paidOrders.paidOrders[index].services,
                                  ),
                                ),
                              );
                            },
                            child: OrderCard(
                              userName: paidOrders.paidOrders[index].username,
                              date: paidOrders.paidOrders[index].createdAt.date
                                  .split(' ')[0],
                              time: paidOrders.paidOrders[index].createdAt.date
                                  .split(' ')[1]
                                  .split('.')[0],
                              serviceName: paidOrders.paidOrders[index]
                                  .services[0].userService.type,
                              image: paidOrders.paidOrders[index].userImage,
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
