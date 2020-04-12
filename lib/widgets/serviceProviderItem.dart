import 'package:flutter/material.dart';
import '../mainScreens/serviceProviderScreens/editItemScreen.dart';
import '../widgets/generalAlertDialog.dart';
import 'package:provider/provider.dart';
import '../models/advertiserServicesModel.dart' show Service;
import '../providers/homePageProvider.dart';

class ServiceProviderItem extends StatefulWidget {
  final String type;

  ServiceProviderItem({@required this.type});

  @override
  _ServiceProviderItemState createState() => _ServiceProviderItemState();
}

class _ServiceProviderItemState extends State<ServiceProviderItem> {
  Map<dynamic, dynamic> data;

  //-----------------------------methods----------------------------------------
  Widget _showOptions() {
    return PopupMenuButton(
        elevation: 7.0,
        itemBuilder: (_) => <PopupMenuItem<String>>[
              new PopupMenuItem<String>(
                  child: Container(
                    width: 70.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'تعديل',
                          style: TextStyle(
                            color: Color.fromRGBO(104, 57, 120, 10),
                            fontSize: 12.0,
                            fontFamily: 'beINNormal',
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        SizedBox(
                          width: 15.0,
                          height: 15.0,
                          child: Image.asset(
                            'assets/icons/edit.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  value: 'edit'),
              new PopupMenuItem<String>(
                  child: Container(
                    width: 70.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'حذف',
                          style: TextStyle(
                            color: Color.fromRGBO(104, 57, 120, 10),
                            fontSize: 12.0,
                            fontFamily: 'beINNormal',
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        SizedBox(
                          width: 15.0,
                          height: 15.0,
                          child: Image.asset(
                            'assets/icons/dustbin.png',
                            fit: BoxFit.cover,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  value: 'delete'),
            ],
        padding: const EdgeInsets.all(0.0),
        onSelected: _onSelected);
  }

  void _onSelected(value) {
    if (value == 'edit') {
      _edit();
    } else {
      _showConfirmDialog(context);
    }
  }

  void _edit() {
    Navigator.of(context).pushNamed(EditItemScreen.routeName, arguments: data);
  }

  void _remove() async {
    await Provider.of<HomePage>(context, listen: false)
        .deleteService(data['id']);
    await Provider.of<HomePage>(context, listen: false)
        .fetchAdvertiserServices();
    await Provider.of<HomePage>(context, listen: false).fetchAdvertiserOffers();
  }

  Future<void> _showConfirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return GeneralDialog(
            content: 'هل بالفعل تريد حذف هذه الخدمه ؟',
            toDOFunction: _remove,
          );
        });
  }

  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    print(':::::::::::::::::::::::::::::::ItemProviderScreen');

    final item = Provider.of<Service>(context, listen: false);
    data = {
      'id': item.id,
      'price': item.price,
      'offer': item.offer,
      'name': item.type,
      'desc': item.desc,
      'status': item.status,
      'serviceType': item.serviceId.toString(),
    };
    return Container(
      height: 70.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 2.0,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        color: Colors.white,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(
          left: 2.0,
          right: 5.0,
        ),
        title: widget.type == 'offers'
            ? Row(
                children: <Widget>[
                  Text(
                    item.type,
                    style: TextStyle(
                      color: Color.fromRGBO(104, 57, 120, 10),
                      fontSize: 14.0,
                      fontFamily: 'beINNormal',
                    ),
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Text(
                    '(' + item.price + '  ريال)',
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontFamily: 'beINNormal',
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    item.offer + '  ريال',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 14.0,
                      fontFamily: 'beINNormal',
                    ),
                  ),
                ],
              )
            : Row(
                children: <Widget>[
                  Text(
                    item.type,
                    style: TextStyle(
                      color: Color.fromRGBO(104, 57, 120, 10),
                      fontSize: 14.0,
                      fontFamily: 'beINNormal',
                    ),
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Text(
                    item.price + '  ريال',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 14.0,
                      fontFamily: 'beINNormal',
                    ),
                  ),
                ],
              ),
        subtitle: Text(
          item.desc,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
            fontFamily: 'beINNormal',
          ),
          softWrap: true,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: _showOptions(),
      ),
    );
  }
}
