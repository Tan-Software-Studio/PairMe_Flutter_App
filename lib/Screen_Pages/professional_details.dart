import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pair_me/Modal/user_profile_modal.dart';
import 'package:pair_me/Screen_Pages/business_address.dart';
import 'package:pair_me/Widgets/Background_img.dart';
import 'package:pair_me/Widgets/custom_button.dart';
import 'package:pair_me/Widgets/custom_loader.dart';
import 'package:pair_me/Widgets/custom_texts.dart';
import 'package:pair_me/Widgets/stepper.dart';
import 'package:pair_me/Widgets/textfield.dart';
import 'package:pair_me/cubits/Professional_details_update.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/helper/Size_page.dart';
import 'package:steps_indicator/steps_indicator.dart';

class Professional_Details extends StatefulWidget {
  String Name,job,domain,email,category,expe,skill,education,univercity;
  Professional_Details({super.key,required this.Name,required this.job,required this.domain,required this.email,required this.category,required this.expe,required this.skill,required this.education,required this.univercity,});

  @override
  State<Professional_Details> createState() => _Professional_DetailsState();
}

class _Professional_DetailsState extends State<Professional_Details> {
  ProfessionalDetailsUpdateCubit professionalDetailsUpdateCubit = ProfessionalDetailsUpdateCubit();
  final TextEditingController _compnyName = TextEditingController();
  final TextEditingController _jobTitle = TextEditingController();
  final TextEditingController _compnyDomain = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _categorycontroller = TextEditingController();
  final TextEditingController _experiencecontroller = TextEditingController();
  final TextEditingController _skillcontroller = TextEditingController();
  final TextEditingController _educationcontroller = TextEditingController();
  final TextEditingController _univercitycontroller = TextEditingController();
  String img= '';
  String Uname= '';
  final List _categorys = [
    'Entrepreneurship',
    'Leadership',
    'Management',
    'Finance',
  ];
  final List _experiences = [
    '1 years',
    '2 years',
    '3 years',
    '4 years',
  ];
  final List _skills = [
    'Graphic Design',
    'Web Design',
    'Communication',
    'Project management',
    'Problem solving',
    'Creativity',
    'Data analysis',
    'Software development',
    'Presentation',
    'Data mining',
    'Troubleshooting',
    'Artificial intelligence',
    'Machine learning',
    'Cloud computing',
    'Cybersecurity',
    'Blockchain and cryptocurrencies',
    'Analytical thinking',
    'Application Development',
    'Architecture',
    'UI / UX',
  ];
  bool _category = false;
  bool _experience = false;
  bool _skill = false;
  bool _education = false;
  getData(){
    _compnyName.text = widget.Name;
    _jobTitle.text = widget.job;
    _compnyDomain.text = widget.domain;
    _email.text = widget.email;
    _categorycontroller.text = widget.category;
    _experiencecontroller.text = widget.expe;
    _skillcontroller.text = widget.skill;
    _educationcontroller.text = widget.education;
    _univercitycontroller.text = widget.univercity;
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Stack(
          children: [
            Background_Img(context),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                titleSpacing: 0,
                centerTitle: false,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                automaticallyImplyLeading: false,
                leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left:8),
                      child: Icon(Icons.arrow_back_ios_rounded),
                    )),
                title: custom_header(text: "Professional Details"),
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
                          "Your new password cannot be the same as a previous password."),
                      SizedBox(
                        height: screenHeight(context, dividedBy: 50),
                      ),
                      custom_textfield_header(text: 'Company Name'),
                      Custom_textfield(context,
                          show_icon: false,
                          onPress: () {},
                          hint: 'Company Name',
                          controller: _compnyName,
                          hidetext: false,
                          readOnly: false),
                      custom_textfield_header(text: 'Add role / Job title',header: true),
                      Custom_textfield(context,
                          show_icon: false,
                          onPress: () {},
                          hint: 'Job title',
                          controller: _jobTitle,
                          hidetext: false,
                          readOnly: false),
                      custom_textfield_header(text: 'Company Domain'),
                      Custom_textfield(context,
                          show_icon: false,
                          onPress: () {},
                          hint: 'Company Domain',
                          controller: _compnyDomain,
                          hidetext: false,
                          readOnly: false),
                      custom_textfield_header(text: 'Email',header: true),
                      Custom_textfield(context,
                          show_icon: false,
                          onPress: () {},
                          hint: 'Your email',
                          controller: _email,
                          hidetext: false,
                          readOnly: false),
                      custom_textfield_header(text: 'Category',header: true),
                      Custom_textfield(context,
                          show_icon: true,
                          image: _category ?'assets/Images/Vector.png' : 'assets/Images/right_arrow.png',
                          onTap: () {
                            setState(() {
                              _category = !_category;
                            });
                          },
                          readOnly: true, onPress: () {
                            setState(() {
                              _category = !_category;
                            });
                          },
                          hint: 'Select',
                          hidetext: false,
                          controller: _categorycontroller),
                      _category
                          ? Container(
                        height: screenHeight(context, dividedBy: 8),
                        width: screenWidth(context),
                        margin: EdgeInsets.only(bottom: screenHeight(context,dividedBy: 150)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
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
                        child: Padding(
                            padding:  EdgeInsets.symmetric(
                                vertical: screenHeight(context,dividedBy: 100), horizontal: 10),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: const ClampingScrollPhysics(),
                              itemCount: _categorys.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: screenHeight(context,dividedBy: 150)),
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _categorycontroller.text =
                                          _categorys[index];
                                          _category = !_category;
                                        });
                                      },
                                      child: custom_text(
                                          text: _categorys[index],
                                          color: const Color(0xff303030))),
                                );
                              },
                            )
                        ),
                      )
                          : const SizedBox(),
                      custom_textfield_header(text: 'Business Experience'),
                      Custom_textfield(context,
                          show_icon: true,
                          image: _experience ?'assets/Images/Vector.png' : 'assets/Images/right_arrow.png',
                          onTap: () {
                            setState(() {
                              _experience = !_experience;
                            });
                          },
                          readOnly: true, onPress: () {
                            setState(() {
                              _experience = !_experience;
                            });
                          },
                          hint: "Select",
                          hidetext: false,
                          controller: _experiencecontroller),
                      _experience
                          ? Container(
                        height: screenHeight(context, dividedBy: 7.5),
                        width: screenWidth(context),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
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
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight(context,dividedBy: 70), horizontal: 10),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: _experiences.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: screenHeight(context,dividedBy: 100)),
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _experiencecontroller.text =
                                          _experiences[index];
                                          _experience = !_experience;
                                        });
                                      },
                                      child: custom_text(
                                          text: _experiences[index],
                                          color: const Color(0xff303030))),
                                );
                              },
                            )),
                      )
                          : const SizedBox(),
                      custom_textfield_header(text: 'Skills'),
                      Custom_textfield(context,
                          show_icon: false,
                          image: _skill ?'assets/Images/Vector.png' : 'assets/Images/right_arrow.png',
                          onTap: () {
                            // setState(() {
                            //   _skill = !_skill;
                            // });
                          },
                          readOnly: false, onPress: () {
                            // setState(() {
                            //   _skill = !_skill;
                            // });
                          },
                          hint: "Select",
                          hidetext: false,
                          controller: _skillcontroller),
                      // _skill
                      //     ? Container(
                      //
                      //   height: screenHeight(context, dividedBy: 7.5),
                      //   width: screenWidth(context),
                      //   margin: const EdgeInsets.only(bottom: 10),
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(7),
                      //       color: Colors.white,
                      //       boxShadow: const [
                      //         BoxShadow(
                      //           color: Colors.grey,
                      //           offset: Offset(
                      //             1,
                      //             1,
                      //           ),
                      //           blurRadius: 4,
                      //           // spreadRadius: 1.0,
                      //         ),
                      //       ]),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       SizedBox(height: screenHeight(context,dividedBy: 85),),
                      //       Padding(
                      //         padding: const EdgeInsets.symmetric( horizontal: 10),
                      //         child: custom_text(
                      //             text: _skills[0],
                      //             color: const Color(0xff303030)),
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.symmetric( horizontal: 10,vertical: 5),
                      //         child: custom_text(
                      //             text: _skills[1],
                      //             color: const Color(0xff303030)),
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.symmetric( horizontal: 10),
                      //         child: custom_text(
                      //             text: _skills[2],
                      //             color: const Color(0xff303030)),
                      //       ),
                      //       SizedBox(height: screenHeight(context,dividedBy: 85),),
                      //       const Divider(
                      //         height: 0,
                      //       ),
                      //       Container(
                      //         alignment: Alignment.center,
                      //         height: screenHeight(context,dividedBy: 30),
                      //         child:Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             const Text('Show all 17 skills',style: TextStyle(fontWeight: FontWeight.w400,fontFamily: 'Roboto',fontSize: 10,color: AppColor.skyBlue),),
                      //             Container(
                      //               margin: EdgeInsets.only(left: screenWidth(context,dividedBy: 65)),
                      //               height: screenHeight(context,dividedBy: 65),
                      //               width: screenWidth(context,dividedBy: 30),
                      //               child:  Image(image: const AssetImage('assets/Images/LineArrow.png')),
                      //             )
                      //           ],
                      //         ),
                      //       )
                      //
                      //     ],
                      //   ),
                      // )
                      //     : const SizedBox(),
                      custom_textfield_header(text: 'Education'),
                      Custom_textfield(context,
                          show_icon: true,
                          image: _education
                              ? 'assets/Images/Vector.png'
                              : 'assets/Images/right_arrow.png',
                          onTap: () {

                          },
                          readOnly: false,
                          onPress: () {
                            setState(() {
                              _education = !_education;
                            });
                          },
                          hint: "Select",
                          hidetext: false,
                          controller: _educationcontroller),
                      _education
                          ? Container(
                        // height:
                        //     screenHeight(context, dividedBy: 10),
                        width: screenWidth(context),
                        margin: const EdgeInsets.only(bottom: 10),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      _educationcontroller.text =
                                      "B.Com - Bachelor of Commerce";
                                      _education = !_education;
                                    });
                                  },
                                  child: const Text(
                                      'B.Com - Bachelor of Commerce')),
                              SizedBox(height: screenHeight(context,dividedBy: 100),),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      _educationcontroller.text =
                                      "BCA - Bachelor of Computer Applications";
                                      _education = !_education;
                                    });
                                  },
                                  child: const Text(
                                      'BCA - Bachelor of Computer Applications')),
                              // SizedBox(height: screenHeight(context,dividedBy: 205),),
                            ],
                          ),
                        ),
                      )
                          : const SizedBox(),
                      custom_textfield_header(text: 'University'),
                      Custom_textfield(context,
                          show_icon: true,
                          image: _education
                              ? 'assets/Images/Vector.png'
                              : 'assets/Images/right_arrow.png',
                          onTap: () {

                          },
                          readOnly: false,
                          onPress: () {
                            setState(() {
                              _education = !_education;
                            });
                          },
                          hint: "Select",
                          hidetext: false,
                          controller: _univercitycontroller),
                      _education
                          ? Container(
                        // height:
                        //     screenHeight(context, dividedBy: 10),
                        width: screenWidth(context),
                        margin: const EdgeInsets.only(bottom: 10),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      _univercitycontroller.text =
                                      "Veer Narmad South Gujarat University";
                                      _education = !_education;
                                    });
                                  },
                                  child: const Text(
                                      'Veer Narmad South Gujarat University')),
                              // SizedBox(height: screenHeight(context,dividedBy: 205),),
                            ],
                          ),
                        ),
                      )
                          : const SizedBox(),

                     BlocBuilder<ProfessionalDetailsUpdateCubit,ProfessionalDetailsUpdateState>(builder: (context, state) {
                       if(state is ProfessionalDetailsUpdateLoading){
                         return Padding(
                           padding: EdgeInsets.symmetric(vertical: screenHeight(context, dividedBy: 20)),
                           child: Center(child: customLoader(),),
                         );
                       }
                       return  Custom_botton(
                         context,
                         text:'SAVE',
                         onTap: () {
                           String role = _jobTitle.text[0].toUpperCase() + _jobTitle.text.substring(1);
                           professionalDetailsUpdateCubit.ProfessionalDetailsUpdateService( company_name: _compnyName.text, add_role: role, company_domain: _compnyDomain.text, email: _email.text, category: _categorycontroller.text, business_experience: _experiencecontroller.text, skills: _skillcontroller.text, education: _educationcontroller.text, university: _univercitycontroller.text, context: context).then((value) => Navigator.pop(context,'refresh'));
                           //  Navigator.pop(context);
                         }, height: screenHeight(context,dividedBy: 20),
                       );
                     },)
                    ],
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
