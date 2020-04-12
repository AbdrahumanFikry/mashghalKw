import 'package:flutter/material.dart';
import 'package:mashghal_co/mainScreens/coiffeurDetails.dart';
import 'package:mashghal_co/mainScreens/serviceProviderScreens/editItemScreen.dart';
import 'package:mashghal_co/models/userHomePageModel.dart';
import 'package:mashghal_co/widgets/loader.dart';
import 'package:provider/provider.dart';
import '../providers/homePageProvider.dart';
import '../models/advertiserServicesModel.dart';

class SearchList extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'searchScreen';

  final String type;
  final bool isAuth;
  SearchList({this.type, this.isAuth});

  @override
  _SearchListState createState() => new _SearchListState();
}

class _SearchListState extends State<SearchList> {
  //---------------------------variables---------------------------------------
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> _list;
  bool _isSearching;
  bool _isLoading = false;
  String _searchText = "";

  //-----------------------------methods----------------------------------------
  _SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    super.initState();
    _isSearching = false;
    init(widget.isAuth);
  }

  void init(bool isAuth) async {
    await Provider.of<HomePage>(context, listen: false)
        .fetchAdvertiserServices();
    if(isAuth)await Provider.of<HomePage>(context, listen: false).fetchAdvertiserOffers();
    await Provider.of<HomePage>(context, listen: false).fetchUserHomePage();
    setState(() {
      _isLoading = false;
    });
    _list = List();
    if (widget.type != 'user') {
      final list1 = Provider.of<HomePage>(context, listen: false)
          .advertiserServices
          .data
          .services;
      final list2 = Provider.of<HomePage>(context, listen: false)
          .advertiserOffers
          .data
          .services;
      list1.forEach((i) {
        _list.add(i.type);
      });
      list2.forEach((i) {
        _list.add(i.type);
      });
    } else {
      final list3 = Provider.of<HomePage>(context, listen: false)
          .userHomePageModel
          .data
          .homes;
      final list4 = Provider.of<HomePage>(context, listen: false)
          .userHomePageModel
          .data
          .salons;

      list3.forEach((i) {
        _list.add(i.name);
      });
      list4.forEach((i) {
        _list.add(i.name);
      });
    }
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  List<ChildItem> _buildList() {
    init(widget.isAuth);
    return _list.map((contact) => new ChildItem(contact, widget.type)).toList();
  }

  List<ChildItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _list
          .map((contact) => new ChildItem(contact, widget.type))
          .toList();
    } else {
      List<String> _searchList = List();
      for (int i = 0; i < _list.length; i++) {
        String name = _list.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(name);
        }
      }
      return _searchList
          .map((contact) => new ChildItem(contact, widget.type))
          .toList();
    }
  }

  //----------------------------------build-------------------------------------
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: new Scaffold(
        key: key,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 218, 241, 10),
          elevation: 7.0,
          centerTitle: true,
          title: new TextField(
            controller: _searchQuery,
            style: new TextStyle(
              color: Color.fromRGBO(104, 57, 120, 10),
            ),
            decoration: new InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(104, 57, 120, 10),
                  width: 0.5,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(104, 57, 120, 10),
                  width: 1.0,
                ),
              ),
              suffixIcon: Icon(
                Icons.search,
                color: Color.fromRGBO(104, 57, 120, 10),
              ),
              hintText: 'بحث ...',
              hintStyle: new TextStyle(
                color: Color.fromRGBO(104, 57, 120, 10),
              ),
            ),
            onTap: _handleSearchStart,
          ),
          leading: IconButton(
              icon: Icon(
                Icons.clear,
                color: Color.fromRGBO(104, 57, 120, 10),
              ),
              onPressed: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                setState(() {
                  _isSearching = false;
                  _searchQuery.clear();
                });
                Navigator.of(context).pop();
              }),
        ),
        body: _isLoading
            ? Center(
                child: ColorLoader(
                  dotRadius: 5.0,
                  radius: 15.0,
                ),
              )
            : new ListView(
                padding: new EdgeInsets.symmetric(vertical: 8.0),
                children: _isSearching ? _buildSearchList() : _buildList(),
              ),
      ),
    );
  }
}

//------------------------------------------------------------------------------
class ChildItem extends StatelessWidget {
  final String name;
  final String type;

  ChildItem(this.name, this.type);

  @override
  Widget build(BuildContext context) {
    return type == 'user'
        ? ListTile(
            onTap: () {
              int index = 0;
              CategoryModel item;
              index = Provider.of<HomePage>(context, listen: false)
                  .userHomePageModel
                  .data
                  .homes
                  .indexWhere((i) => i.name == name);
              if (index == -1) {
                index = Provider.of<HomePage>(context, listen: false)
                    .userHomePageModel
                    .data
                    .salons
                    .indexWhere((i) => i.name == name);
                item = Provider.of<HomePage>(context, listen: false)
                    .userHomePageModel
                    .data
                    .salons[index];
              } else {
                item = Provider.of<HomePage>(context, listen: false)
                    .userHomePageModel
                    .data
                    .homes[index];
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CoiffeurDetailsScreen(
                    id: item.id,
                  ),
                ),
              );
            },
            title: Text(
              this.name,
              style: TextStyle(
                color: Color.fromRGBO(104, 57, 120, 10),
                fontSize: 16.0,
                fontFamily: 'beINNormal',
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Color.fromRGBO(104, 57, 120, 10),
            ),
          )
        : ListTile(
            onTap: () {
              int index = 0;
              Service item;
              index = Provider.of<HomePage>(context, listen: false)
                  .advertiserServices
                  .data
                  .services
                  .indexWhere((i) => i.type == name);
              if (index == -1) {
                index = Provider.of<HomePage>(context, listen: false)
                    .advertiserOffers
                    .data
                    .services
                    .indexWhere((i) => i.type == name);
                item = Provider.of<HomePage>(context, listen: false)
                    .advertiserOffers
                    .data
                    .services[index];
              } else {
                item = Provider.of<HomePage>(context, listen: false)
                    .advertiserServices
                    .data
                    .services[index];
              }
              Navigator.of(context)
                  .pushNamed(EditItemScreen.routeName, arguments: {
                'id': item.id,
                'price': item.price,
                'offer': item.offer,
                'name': item.type,
                'desc': item.desc,
              });
            },
            title: Text(
              this.name,
              style: TextStyle(
                color: Color.fromRGBO(104, 57, 120, 10),
                fontSize: 16.0,
                fontFamily: 'beINNormal',
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Color.fromRGBO(104, 57, 120, 10),
            ),
          );
  }
}
