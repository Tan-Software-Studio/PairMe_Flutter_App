import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pair_me/Widgets/custom_button.dart';
import 'package:pair_me/Widgets/custom_loader.dart';
import 'package:pair_me/Widgets/custom_texts.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/helper/Size_page.dart';

class Location_page extends StatefulWidget {
  const Location_page({super.key});

  @override
  State<Location_page> createState() => _Location_pageState();
}

class _Location_pageState extends State<Location_page> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  bool change = false;
final TextEditingController _map = TextEditingController();
  static  CameraPosition? _kGooglePlex ;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }


  Future<Position> getUserCurrentLocation () async {
    await Geolocator.requestPermission().then((value) {

    }).onError((error, stackTrace) {
      print("error"+error.toString());
    });

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> Getaddress(Position position) async {

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserCurrentLocation().then((value) async {
      _kGooglePlex = await CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );
      List<Placemark> placemark = await placemarkFromCoordinates(value.latitude, value.longitude);
      _map.text = "${placemark[0].street}, ${placemark[0].administrativeArea}, ${placemark[0].country}";
          print('placemark =====> $placemark');
          change = true;
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.white,
      body: SizedBox(
        height: screenHeight(context),
        width: screenWidth(context),
        child:  Stack(
          alignment: Alignment.center,
          children: [
            change ? Positioned(
              top: 0.0,
              child:  SizedBox(
                height: screenHeight(context,dividedBy: 1.6),
                width: screenWidth(context),
                child: GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: _kGooglePlex!,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ) :SizedBox(),
            change ? Positioned(
              bottom: 0.0,
              child: Container(
                height: screenHeight(context,dividedBy: 2.281),
                width: screenWidth(context),
                decoration: const BoxDecoration(
                  color: AppColor.white,
                 // color: Colors.greenAccent,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth(context,dividedBy: 20),vertical: screenHeight(context,dividedBy: 30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      custom_header(text: "Select Location"),
                      const Text('Your Location ',style: TextStyle(color: AppColor.skyBlue,fontWeight: FontWeight.w500,fontFamily: 'Roboto',fontSize: 12),),
                       TextField(
                        controller: _map,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: screenHeight(context,dividedBy: 50)),
                        child: custom_discription(text: "Save As"),
                      ),
                      Row(
                        children: [
                          Container(
                            height: screenHeight(context,dividedBy: 20),
                            width: screenWidth(context,dividedBy: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xffF5F5F5),
                              borderRadius: BorderRadius.circular(23)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: screenHeight(context,dividedBy: 35),
                                  width: screenHeight(context,dividedBy: 35),
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(image: AssetImage('assets/Images/homeIcon.png'))
                                  ),
                                ),
                                SizedBox(width: screenWidth(context,dividedBy: 150),),
                                const Text('Home',style: TextStyle(fontFamily: 'Roboto',fontSize: 12,fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                          SizedBox(width: screenWidth(context,dividedBy: 30),),
                          Container(
                            height: screenHeight(context,dividedBy: 20),
                            width: screenWidth(context,dividedBy: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xffF5F5F5),
                              borderRadius: BorderRadius.circular(23)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: screenHeight(context,dividedBy: 35),
                                  width: screenHeight(context,dividedBy: 35),
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(image: AssetImage('assets/Images/officeicon.png'))
                                  ),
                                ),
                                SizedBox(width: screenWidth(context,dividedBy: 150),),
                                const Text('Office',style: TextStyle(fontFamily: 'Roboto',fontSize: 12,fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight(context,dividedBy: 25),),
                      Custom_botton(
                        context,
                        text: 'Save Address',
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) {
                          //   return const Business_Address();
                          // },));
                        }, height: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ) : Center(child: customLoader(),),
            Positioned(
              left: screenWidth(context,dividedBy: 30),
              top: screenHeight(context,dividedBy: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios_rounded,size: 25,),
                ))
          ],
        )
      ),
    );
  }
}
