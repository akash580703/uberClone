import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/helpers/constants.dart';
import '/helpers/style.dart';
import '/providers/app_state.dart';
import '/providers/user.dart';

class DestinationSelectionWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // FocusScopeNode currentFocus = FocusScope.of(context);
    // print("currentFocus");
    // print(currentFocus);
    AppStateProvider appState = Provider.of<AppStateProvider>(context);
    // appState.destinationController=null;
    return DraggableScrollableSheet(
      initialChildSize: 0.48,
      minChildSize: 0.48,
      builder: (BuildContext context, myscrollController) {
        return Container(
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: grey.withOpacity(.8),
                    offset: Offset(3, 2),
                    blurRadius: 7)
              ]),
          child: ListView(
            controller: myscrollController,
            children: [
              Icon(
                Icons.remove,
                size: 40,
                color: grey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Container(
                  color: grey.withOpacity(.3),
                  child: TextField(
                    
                    // focusNode: FocusNode().unfocus(),
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      Prediction p = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: GOOGLE_MAPS_API_KEY,
                          mode: Mode.overlay, // Mode.fullscreen
                          // language: "pt",
                          components: [
                            new Component(Component.country,
                                preferences.getString(COUNTRY))
                          ]);
                      PlacesDetailsResponse detail =
                          await places.getDetailsByPlaceId(p.placeId);
                      double lat = detail.result.geometry.location.lat;
                      double lng = detail.result.geometry.location.lng;
                      appState.changeRequestedDestination(
                          reqDestination: p.description, lat: lat, lng: lng);
                      appState.updateDestination(destination: p.description);
                      LatLng coordinates = LatLng(lat, lng);
                      appState.setDestination(coordinates: coordinates);
                      appState.addPickupMarker(appState.center);
                      appState.indxed();
                      // await appState.sendRequest();
                      appState.changeWidgetShowed(
                          showWidget: Show.PICKUP_SELECTION);
                      // appState.sendRequest(coordinates: coordinates);
                    },
                    textInputAction: TextInputAction.go,
                    controller: appState.destinationController,
                    cursorColor: Colors.blue.shade900,
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(left: 20, bottom: 15),
                        width: 10,
                        height: 10,
                        child: Icon(
                          Icons.location_on,
                          color: primary,
                        ),
                      ),
                      hintText: "Where to go?",
                      hintStyle: TextStyle(
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepOrange[300],
                  child: Icon(
                    Icons.home,
                    color: white,
                  ),
                ),
                title: Text("Home",style: const TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text("25th avenue, 23 street"),
                trailing:Wrap(
                  direction: Axis.vertical,
                  spacing: 5,        
            children: <Widget>[
            Text("Home"),Text("Home",style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.grey,),),
          ]),

              ),
              ListTile(
          
                leading: CircleAvatar(
                  backgroundColor: Colors.deepOrange[300],
                  child: Icon(
                    Icons.work,
                    color: white,
                  ),
                ),
                title: Text("Work"),
                subtitle: Text("25th avenue, 23 street"),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.18),
                  child: Icon(
                    Icons.history,
                    color: primary,
                  ),
                ),
                title: Text("Recent location"),
                subtitle: Text("25th avenue, 23 street"),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(.18),
                  child: Icon(
                    Icons.history,
                    color: primary,
                  ),
                ),
                title: Text("Recent location"),
                subtitle: Text("25th avenue, 23 street"),
              ),
            ],
          ),
        );
      },
    );
  }
}
