import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pair_me/Modal/city&state.dart';
import 'package:pair_me/Widgets/Background_img.dart';
import 'package:pair_me/Widgets/custom_button.dart';
import 'package:pair_me/Widgets/custom_loader.dart';
import 'package:pair_me/Widgets/custom_texts.dart';
import 'package:pair_me/Widgets/textfield.dart';
import 'package:pair_me/cubits/City&state.dart';
import 'package:pair_me/cubits/address_update.dart';
import 'package:pair_me/helper/Size_page.dart';
import 'package:pair_me/helper/Apis.dart';


class Address_Details extends StatefulWidget {
  String line1,line2,country,state,city,code;
  Address_Details({super.key,required this.line1,required this.line2,required this.country,required this.state,required this.city,required this.code,});

  @override
  State<Address_Details> createState() => _Address_DetailsState();
}

class _Address_DetailsState extends State<Address_Details> {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  bool _contry = false;
  bool _state = false;
  bool _city = false;
  CityStateCubit cityStateCubit = CityStateCubit();
  AddressDetailsCubit addressDetailsCubit = AddressDetailsCubit();
  final TextEditingController _Address = TextEditingController();
  final TextEditingController _Address2 = TextEditingController();
  final TextEditingController _Zipcode = TextEditingController();
  final TextEditingController _Contry = TextEditingController();
  final TextEditingController _State = TextEditingController();
  final TextEditingController _City = TextEditingController();
  CityandState cityandState = CityandState();
  List _states = [];
  List _citys = [];
  List resultstates = [];
  List resultcity = [];
  GetData(String country) async {
    cityandState = (await cityStateCubit.getcalendarEvents(country: country))!;
    setState(() {});
  }
  Future getStateandcitys ({required String country}) async {
    final dio = Dio();
    try {
      Response response = await dio.get('${apis.city}/$country');
      Map _map = response.data;
      final st = _map['state']['states'];
      final st1 = _map['city']['cities'];
      _states = st;
      _citys = st1;
      setState(() {
      });
      print("map ==> $_citys as Strin");
    } on Exception catch (e) {
      print("you are fully fail my friend" + e.toString());
      // TODO
    }
  }
  getdata(){
    _Address.text = widget.line1;
    _Address2.text = widget.line2;
    _Contry.text = widget.country;
    _State.text = widget.state;
    _City.text = widget.city;
    _Zipcode.text = widget.code;
    _City.text.isNotEmpty ? getStateandcitys(country: _Contry.text).then((value) {
      resultcity = _citys.where((element) => element.toString().toLowerCase().contains(_City.text.toLowerCase())).toList() ?? [];
    }) : null;
    _City.text.isNotEmpty ? GetData( _Contry.text) : null;
    _State.text.isNotEmpty ? getStateandcitys(country: _Contry.text).then((value) {
      resultstates = _states.where((element) => element['name'].toString().toLowerCase().contains( _State.text.toLowerCase())).toList() ?? [];
    }) : null;
    _State.text.isNotEmpty ? GetData( _Contry.text) : null;
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cityStateCubit = BlocProvider.of<CityStateCubit>(context);
    addressDetailsCubit = BlocProvider.of<AddressDetailsCubit>(context);
    getdata();
    // getHttp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
          body: SizedBox(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Stack(
          children: [
            Background_Img(context),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                centerTitle: false,
                titleSpacing: 0,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                automaticallyImplyLeading: false,
                leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.arrow_back_ios_rounded),
                    )),
                title: custom_header(text: "Address Details"),
              ),
              body: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth(context, dividedBy: 15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      custom_discription(
                          text:
                              "Please show some alternative font designs throughout the app"),
                      SizedBox(
                        height: screenHeight(context, dividedBy: 50),
                      ),
                      custom_textfield_header(text: 'Address'),
                      Custom_textfield(context,
                          show_icon: false,
                          readOnly: false,
                          onPress: () {},
                          hint: "Address line 1",
                          mxline: 2,
                          hidetext: false,
                          controller: _Address),
                      Custom_textfield(context,
                          show_icon: false,
                          readOnly: false,
                          onPress: () {},
                          hint: "Address line 2",
                          mxline: 2,
                          hidetext: false,
                          controller: _Address2),
                      custom_textfield_header(text: 'Country'),
                      Custom_textfield(context,
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: true,
                              onSelect: (Country country) {
                                print('Select country: ${country.phoneCode}');
                                print('Select country: ${country.name}');
                                _Contry.text = country.name;
                                GetData(_Contry.text);
                                getStateandcitys(country: _Contry.text);
                                // countryCodeSelect = country.phoneCode;
                                // countryCodeflagsvg = country.flagEmoji;
                                //flutterToast(country.displayNameNoCountryCode, true);
                                setState(() {});
                              },
                            );
                          },
                          show_icon: true,
                          image: _contry
                              ? 'assets/Images/Vector.png'
                              : 'assets/Images/right_arrow.png',
                          readOnly: true,
                          onPress: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: true,
                              onSelect: (Country country) {
                                print(
                                    'Select country: ${country.phoneCode}');
                                print(
                                    'Select country: ${country.name}');
                                _Contry.text = country.name;
                                GetData(_Contry.text);
                                getStateandcitys(country: _Contry.text);
                                // countryCodeSelect = country.phoneCode;
                                // countryCodeflagsvg = country.flagEmoji;
                                //flutterToast(country.displayNameNoCountryCode, true);
                                setState(() {});
                              },
                            );
                          },
                          hint: "Select",
                          hidetext: false,
                          controller: _Contry),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                custom_textfield_header(text: 'State'),
                                Custom_textfield(context,
                                    onChanged: (value) {
                                      resultstates = _states.where((element) => element['name'].toString().toLowerCase().contains(value.toLowerCase())).toList() ?? [];
                                      print("result ==> $resultstates");
                                      setState(() { });
                                    },
                                    onTap: () {
                                      setState(() {
                                        _state = true;
                                        print("_states ===> $_states");
                                      });
                                    },
                                    show_icon: true,
                                    image: _state
                                        ? 'assets/Images/Vector.png'
                                        : 'assets/Images/right_arrow.png',
                                    readOnly: false,
                                    onPress: () {
                                      setState(() {
                                        _state = !_state;
                                      });
                                    },
                                    hint: "Select",
                                    hidetext: false,
                                    controller: _State),
                                _state
                                    ? Container(
                                    height: screenHeight(context,
                                        dividedBy: 7),
                                    width: screenWidth(context),
                                    margin: const EdgeInsets.only(
                                        bottom: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(7),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(
                                              1,
                                              1,
                                            ),
                                            blurRadius: 4,
                                            // spreadRadius: 1.0,
                                          ),
                                        ]),
                                    child: BlocBuilder<CityStateCubit,
                                        CityStateState>(
                                      builder: (context, state) {
                                        print(state);
                                        if (state is CityStateError)
                                          return const Center(
                                            child: Text("No State"),
                                          );
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: screenHeight(
                                                  context,
                                                  dividedBy: 100),
                                              horizontal: screenWidth(
                                                  context,
                                                  dividedBy: 30)),
                                          child:ListView.builder(
                                            physics:
                                            const ClampingScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemCount: _State.text.isNotEmpty ? resultstates.length : cityandState.state?.states.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  _State.text =_State.text.isNotEmpty ?
                                                  resultstates[index]['name'].toString() : cityandState
                                                      .state
                                                      ?.states[
                                                  index]
                                                      .name;
                                                  _state = !_state;
                                                  setState(() {});
                                                },
                                                child: custom_text(
                                                    text:_State.text.isNotEmpty ? resultstates[index]['name'].toString() :  cityandState.state?.states[index].name,
                                                    color: const Color(
                                                        0xff303030)),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ))
                                    : SizedBox(
                                  height: _city
                                      ? screenHeight(context,
                                      dividedBy: 6.35)
                                      : 0,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenWidth(context, dividedBy: 50),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                custom_textfield_header(text: 'City'),
                                Custom_textfield(
                                    onChanged: (value) {
                                      resultcity = _citys.where((element) => element.toString().toLowerCase().contains(value.toLowerCase())).toList() ?? [];
                                      print("result ==> $resultcity");
                                      setState(() { });
                                    },
                                    onTap: () {
                                      setState(() {
                                        _city = true;
                                      });
                                    },
                                    context,
                                    show_icon: true,
                                    image: _city
                                        ? 'assets/Images/Vector.png'
                                        : 'assets/Images/right_arrow.png',
                                    readOnly: false,
                                    onPress: () {
                                      setState(() {
                                        _city = !_city;
                                      });
                                    },
                                    hint: "Select",
                                    hidetext: false,
                                    controller: _City),
                                _city
                                    ? Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10),
                                  height: screenHeight(context,
                                      dividedBy: 7),
                                  width: screenWidth(context),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(7),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(
                                            1,
                                            1,
                                          ),
                                          blurRadius: 4,
                                          // spreadRadius: 1.0,
                                        ),
                                      ]),
                                  child: BlocBuilder<CityStateCubit,
                                      CityStateState>(
                                    builder: (context, state) {
                                      print(state);
                                      if (state is CityStateError) {
                                        return const Center(
                                          child: Text("No State"),
                                        );
                                      }
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenHeight(
                                                context,
                                                dividedBy: 100),
                                            horizontal: screenWidth(
                                                context,
                                                dividedBy: 30)),
                                        child: ListView.builder(
                                          physics:
                                          const ClampingScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          itemCount:_City.text.isEmpty ? cityandState.city?.cities.length : resultcity.length,
                                          itemBuilder:
                                              (context, index) {
                                            return InkWell(
                                                onTap: () {
                                                  _City
                                                      .text = _City.text.isEmpty ? cityandState
                                                      .city
                                                      ?.cities[
                                                  index] : resultcity[index] ;
                                                  _city = !_city;
                                                  setState(() {});
                                                },
                                                child: custom_text(
                                                    text: _City.text.isEmpty ? cityandState
                                                        .city
                                                        ?.cities[
                                                    index] : resultcity[index],
                                                    color: const Color(
                                                        0xff303030)));
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                )
                                    : SizedBox(
                                  height: _state
                                      ? screenHeight(context,
                                      dividedBy: 6.35)
                                      : 0,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      custom_textfield_header(text: 'Post code / Zip code'),
                      Custom_textfield(context,
                          show_icon: false,
                          number: true,
                          readOnly: false,
                          onPress: () {},
                          hint: "Post code / Zip code",
                          hidetext: false,
                          controller: _Zipcode),
                    BlocBuilder<AddressDetailsCubit,AddressDetailsState>(builder: (context, state) {
                      if(state is AddressDetailsLoading){
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: screenHeight(context, dividedBy: 20)),
                          child: Center(child: customLoader(),),
                        );
                      }
                      return   Custom_botton(
                        context,
                        text: 'SAVE',
                        onTap: () {
                          addressDetailsCubit.AddressDetailsService(address: "${_Address.text},${_Address2.text}", country: _Contry.text, state: _State.text, city: _City.text, zipCode: _Zipcode.text, context: context).then((value) => Navigator.pop(context,'refresh'));
                          //  Navigator.pop(context);
                        },
                        height: screenHeight(context, dividedBy: 20),
                      );
                    },)
                    ],
                  ),
                ),
              ),
            )

          ],
        ),
      )),
    );
  }
}
