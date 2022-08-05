// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:fluttertoast/fluttertoast.dart';
import '/providers/app_state.dart';
import 'package:provider/provider.dart';
import '/helpers/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '/providers/app_state.dart';
import '/widgets/custom_text.dart';
import '/screens/phoneVerf.dart';




void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();

}

class MyAppState extends State<MyApp> {


  
List price=[];
var contexted;
  
  var scaffoldState = GlobalKey<ScaffoldState>();



  
  static const platform = const MethodChannel("razorpay_flutter");

   Razorpay razorpay;
LoginScreens phoneLogs=LoginScreens();
AppStateProvider appState;

  @override
  Widget build(BuildContext context) {
    this.contexted=context;
    
     this.appState = Provider.of<AppStateProvider>(context);
      this.price=[appState.ridePrice,appState.ridePrice2,appState.ridePrice3,appState.ridePrice4];
                                      // builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20.0)), //this right here
                                      child: Container(
                                        height: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SpinKitWave(
                                                color: black,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  
                                                     Text("Pay half of the total amount now to confirm your booking."),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              // LinearPercentIndicator(
                                              //   lineHeight: 4,
                                              //   animation: true,
                                              //   animationDuration: 100000,
                                              //   percent: 1,
                                              //   backgroundColor: Colors.grey
                                              //       .withOpacity(0.2),
                                              //   progressColor:
                                              //       Colors.deepOrange,
                                              // ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  FlatButton(
                                                      onPressed: () {
                                                        openCheckout();
                                                      //   Navigator.pop(context);
                                                      //   appState
                                                      //       .cancelRequest();
                                                      //   scaffoldState
                                                      //       .currentState
                                                      //       .showSnackBar(SnackBar(
                                                                // content: Text(
                                                                //     "Request cancelled!");
                                                      },
                                                      child: CustomText(
                                                        text: "Pay \Rs ${(price[appState.val-1]*100)/2}",
                                                        color:
                                                            Colors.deepOrange,
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
    
 
    
    // return MaterialApp(
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Razorpay Sample App'),
    //     ),
    //     body: Center(
    //         child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: <Widget>[
    //           RaisedButton(onPressed: openCheckout, child: Text('Open'))
    //         ])),
    //   ),
    // );
  

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() async {
    // razorpay = Razorpay();
    var options = {
      'key': 'rzp_test_XGE3cuburZbgC2',
      'amount': (price[appState.val-1]*100)/2,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    print("eeeee");
      
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async{

    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, toastLength: Toast.LENGTH_SHORT);
        print("..........................................................................ttttttttttttttt");
                this.appState.requestDriver(

                                  distance:appState.routeModel.distance.toJson(),
                                  user: await phoneLogs.reloadUserModel(),
                                  lat: appState.pickupCoordinates.latitude,
                                  lng: appState.pickupCoordinates.longitude,
                                  context: this.contexted,
                                  value: appState.val.toString());

                                  this.appState.changeMainContext(this.contexted);
                                  showDialog(
                                  context: this.contexted,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20.0)), //this right here
                                      child: Container(
                                        height: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SpinKitWave(
                                                color: black,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                      text:
                                                          "Looking for a driver"),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              LinearPercentIndicator(
                                                lineHeight: 4,
                                                animation: true,
                                                animationDuration: 100000,
                                                percent: 1,
                                                backgroundColor: Colors.grey
                                                    .withOpacity(0.2),
                                                progressColor:
                                                    Colors.deepOrange,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  FlatButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        appState
                                                            .cancelRequest();
                                                        scaffoldState
                                                            .currentState
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    "Request cancelled!")));
                                                      },
                                                      child: CustomText(
                                                        text: "Cancel Request",
                                                        color:
                                                            Colors.deepOrange,
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });

        
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        toastLength: Toast.LENGTH_SHORT);


  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, toastLength: Toast.LENGTH_SHORT);
  }

    // Widget build(BuildContext context) {
    //   return Container();
    // }
}