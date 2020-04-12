import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mashghal_co/providers/MessagesProvider.dart';
import 'package:mashghal_co/providers/reservationsProvider.dart';
import 'package:provider/provider.dart';
import './providers/homePageProvider.dart';
import './providers/moreScreenProvider.dart';
import './providers/notificationProvider.dart';
import './providers/ordersProvider.dart';
import './providers/Auth.dart';
import './mainScreens/userHomePageScreen.dart';
import './mainScreens/searchScreen.dart';
import './mainScreens/serviceProviderScreens/editInfoSPScreen.dart';
import './mainScreens/serviceProviderScreens/serviceProviderAccountScreen.dart';
import './mainScreens/serviceProviderScreens/removeOrderScreen.dart';
import './mainScreens/serviceProviderScreens/finishingOrderScreen.dart';
import './mainScreens/serviceProviderScreens/newOrderDetailsScreen.dart';
import './mainScreens/serviceProviderScreens/appPaymentScreen.dart';
import './mainScreens/serviceProviderScreens/confirmedOrdersScreen.dart';
import './mainScreens/serviceProviderScreens/finishedOrdersScreen.dart';
import './mainScreens/serviceProviderScreens/ordersScreen.dart';
import './mainScreens/serviceProviderScreens/addItemScreen.dart';
import './mainScreens/serviceProviderScreens/editItemScreen.dart';
import './mainScreens/serviceProviderScreens/serviceProviderHomePageScreen.dart';
import './mainScreens/mapScreen.dart';
import './mainScreens/messagesScreen.dart';
import './mainScreens/chatScreen.dart';
import './mainScreens/favouriteScreen.dart';
import './mainScreens/editInfoScreen.dart';
import './mainScreens/accountScreen.dart';
import './mainScreens/questionsScreen.dart';
import './mainScreens/aboutAppScreen.dart';
import './mainScreens/moreScreen.dart';
import './mainScreens/notificationsScreen.dart';
import './mainScreens/reservationScreen.dart';
import './mainScreens/dateandtimeScreen.dart';
import './mainScreens/servicesScreenFromDetails.dart';
import './mainScreens/offerScreenFromDetails.dart';
import './mainScreens/myWorksScreenFromDetails.dart';
import './mainScreens/coiffeurDetails.dart';
import './mainScreens/bottomNavigationbarScreen.dart';
import './mainScreens/homePageScreen.dart';
import './mainScreens/moreCategoriesScreen.dart';
import './authScreens/termsConditionsScreen.dart';
import './authScreens/verifyCodeScreen.dart';
import './authScreens/SetNewPasswordScreen.dart';
import './authScreens/forgivePasswordScreen.dart';
import './authScreens/serviceProviderSignUpScreen.dart';
import './authScreens/SPloginScreen.dart';
import './authScreens/serviceSelectionScreen.dart';
import './authScreens/splashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          builder: (context) => More(),
        ),
        ChangeNotifierProvider(
          builder: (context) => HomePage(),
        ),
        ChangeNotifierProvider(
          builder: (context) => OrdersProvider(),
        ),
        ChangeNotifierProvider(
          builder: (context) => Notifications(),
        ),
        ChangeNotifierProvider(
          builder: (context) => Reservations(),
        ),
        ChangeNotifierProvider(
          builder: (context) => MessagesProvider(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) =>  MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.white,
            hintColor: Colors.white,
            textTheme: TextTheme(
              title: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: auth.isAuth
              ? BottomNavigationBarScreen(
                  type: auth.type,
                )
              :
          FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, snapShot) =>
                      snapShot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          :
                      ServiceSelectionScreen(),
                ),
          routes: {
            SplashScreen.routeName: (context) => SplashScreen(),
            BottomNavigationBarScreen.routeName: (context) =>
                BottomNavigationBarScreen(type: auth.type),
            ServiceSelectionScreen.routeName: (context) =>
                ServiceSelectionScreen(),
            ServiceProviderLoginScreen.routeName: (context) =>
                ServiceProviderLoginScreen(),
            ForgivePasswordScreen.routeName: (context) =>
                ForgivePasswordScreen(),
            SetNewPasswordScreen.routeName: (context) => SetNewPasswordScreen(),
            VerifyCodeScreen.routeName: (context) => VerifyCodeScreen(),
            HomePageScreen.routeName: (context) =>
                HomePageScreen(type: auth.type),
            MoreCategoriesScreen.routeName: (context) => MoreCategoriesScreen(),
            CoiffeurDetailsScreen.routeName: (context) =>
                CoiffeurDetailsScreen(),
            MyWorksScreenFromDetails.routeName: (context) =>
                MyWorksScreenFromDetails(),
            OfferScreenFromDetails.routeName: (context) =>
                OfferScreenFromDetails(),
            ServicesScreenFromDetails.routeName: (context) =>
                ServicesScreenFromDetails(),
            DateTimeScreen.routeName: (context) => DateTimeScreen(),
            ReservationScreen.routeName: (context) => ReservationScreen(),
            NotificationsScreen.routeName: (context) => NotificationsScreen(),
            MoreScreen.routeName: (context) => MoreScreen(
                  type: auth.type,
                ),
            AboutAppScreen.routeName: (context) => AboutAppScreen(),
            QuestionsScreen.routeName: (context) => QuestionsScreen(),
            AccountScreen.routeName: (context) => AccountScreen(),
            EditInfoScreen.routeName: (context) => EditInfoScreen(),
            FavouriteScreen.routeName: (context) => FavouriteScreen(),
            MessagesScreen.routeName: (context) => MessagesScreen(),
            ChatScreen.routeName: (context) => ChatScreen(),
            TermsAndConditionsScreen.routeName: (context) =>
                TermsAndConditionsScreen(),
            MapScreen.routeName: (context) => MapScreen(),
            ServiceProviderSignupScreen.routeName: (context) =>
                ServiceProviderHomePageScreen(),
            UserHomePageScreen.routeName: (context) => UserHomePageScreen(),
            EditItemScreen.routeName: (context) => EditItemScreen(),
            AddItemScreen.routeName: (context) => AddItemScreen(),
            OrderScreen.routeName: (context) => OrderScreen(),
            FinishedOrdersScreen.routeName: (context) => FinishedOrdersScreen(),
            ConfirmedOrdersScreen.routeName: (context) =>
                ConfirmedOrdersScreen(),
            AppPaymentScreen.routeName: (context) => AppPaymentScreen(),
            NewOrderDetailsScreen.routeName: (context) =>
                NewOrderDetailsScreen(),
            FinishingOrderScreen.routeName: (context) => FinishingOrderScreen(),
            RemovingOrderScreen.routeName: (context) => RemovingOrderScreen(),
            ServiceProviderAccountScreen.routeName: (context) =>
                ServiceProviderAccountScreen(),
            EditInfoSPScreen.routeName: (context) => EditInfoSPScreen(),
            SearchList.routeName: (context) => SearchList(),
          },
        ),
      ),
    );
  }
}
