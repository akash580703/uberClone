import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter/material.dart';

const GOOGLE_MAPS_API_KEY = "AIzaSyA4tx4gOeX7kQJNDgsWe8Pl3NVQds1pmCk";
const COUNTRY = "country";
Firestore firebaseFiretore = Firestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseMessaging fcm = FirebaseMessaging();
GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: GOOGLE_MAPS_API_KEY);

class Constatnts {
  
  static final String logo = "assets/images/logo.png";
  static final String bgleaf = "assets/images/bg_leaf.png";
  static final Color primaryColor = Colors.green;


}
