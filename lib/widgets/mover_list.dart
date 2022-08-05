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




class My extends StatefulWidget {
  @override
  _MoverListWidget createState() => _MoverListWidget();
}



class _MoverListWidget extends State<My>{
//   int keys = 0;
// int selectedIndex;
  //    void keyChange(x) {
  //    this.keys = x;
  // }
  // double elevation=0;
  var val;
  @override
  Widget build(BuildContext context) {
    // FocusScopeNode currentFocus = FocusScope.of(context);
    // print("currentFocus");
    // print(currentFocus);
    AppStateProvider appState = Provider.of<AppStateProvider>(context);
    print(appState.ridePrice-50);
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

              Card(
                elevation: appState.val == 1 ? 2: 0,
              child:ListTile(
             onTap: () {
              setState(() {
            
            appState.val=1;
            
          });
              },            
                leading: CircleAvatar(
                  backgroundColor: Colors.deepOrange[300],
                  child: Icon(
                    Icons.check,
                    color: white,
                  ),
                ),
                title: Text("PickUp 1"),
                subtitle: Text("PickUp 1 info"),
                trailing:Wrap(
                  direction: Axis.vertical,
                  spacing: 5,        
            children: <Widget>[
            Text("\Rs ${appState.ridePrice-50}"),Text("\Rs ${appState.ridePrice}",style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.grey,decoration: TextDecoration.lineThrough),),
          ]),
              ),),



        Card(
        elevation: appState.val  == 2 ? 2: 0,             
              child:ListTile(
              onTap: () {
              setState(() {
            
            appState.val =2;
            
          });
              },               
                leading: CircleAvatar(
                  backgroundColor: Colors.deepOrange[300],
                  child: Icon(
                    Icons.check,
                    color: white,
                  ),
                ),
                title: Text("PickUp 2"),
                subtitle: Text("PickUp 2 info"),
                 trailing:Wrap(
                  direction: Axis.vertical,
                  spacing: 5,        
            children: <Widget>[
              Text("\Rs ${appState.ridePrice2-50}"),Text("\Rs ${appState.ridePrice2}",style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.grey,decoration: TextDecoration.lineThrough),),
            //Text("\Rs${appState.ridePrice2}"),Text("Home",style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.grey,),),
          ]),               
              ),
        ),


        Card(
        elevation: appState.val  == 3 ? 2: 0,             
              child:
              ListTile(
             onTap: () {
              setState(() {
            
            appState.val =3;
            
          });
              },

                leading: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.18),
                  child: Icon(
                    Icons.check,
                    color: primary,
                  ),
                ),
                title: Text("PickUp 3"),
                subtitle: Text("PickUp 3 info"),
                  trailing:Wrap(
                  direction: Axis.vertical,
                  spacing: 5,        
            children: <Widget>[
              Text("\Rs ${appState.ridePrice3-50}"),Text("\Rs ${appState.ridePrice3}",style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.grey,decoration: TextDecoration.lineThrough),),
            //Text("\Rs${appState.ridePrice3}"),Text("Home",style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.grey,),),
          ]),              
              ),),

          Card(
        elevation: appState.val  == 4 ? 2: 0,             
              child:
              ListTile(
             onTap: () {
              setState(() {
          
            appState.val =4;
            
          });
              },                
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(.18),
                  child: Icon(
                    Icons.check,
                    color: primary,
                  ),
                ),
                title: Text("PickUp 4"),
                subtitle: Text("PickUp 4 info"),

                    trailing:Wrap(
                  direction: Axis.vertical,
                  spacing: 5,        
            children: <Widget>[
              Text("\Rs ${appState.ridePrice4-50}"),Text("\Rs ${appState.ridePrice4}",style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.grey,decoration: TextDecoration.lineThrough),),
            //Text("\Rs${appState.ridePrice4-100}"),Text("Home",style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.grey,),),
          ]),            
              ),),

              SizedBox(
                width: double.infinity,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: 20.0,
                  ),
                  child:TextButton(
    child: Text('Book'),
    style: TextButton.styleFrom(
      primary: Colors.white,
      backgroundColor: Colors.teal,
      onSurface: Colors.grey,
      padding: EdgeInsets.symmetric(horizontal:0),
       minimumSize: Size(50, 30),
       ),

    onPressed: () {
      appState.indxed(); 

      
    },
  )
                ),
              ),




            ],
          ),
        );
      },
    );
  }
}
