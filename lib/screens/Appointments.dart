import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_management_system/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:hospital_management_system/services/NetworkHelper.dart';
import 'package:hospital_management_system/widgets/MyTextField.dart';

class Appointments extends StatefulWidget {
  final String userId;

  Appointments({this.userId});

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  bool _loading = false;
  List _appointments;
  double width;
  double height;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _licenseController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    _getAppointments();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _licenseController.dispose();
    _contactController.dispose();
    super.dispose();
  }

// get the appointments list
  Future<http.Response> _getAppointments() async {
    setState(() {
      _loading = true;
    });

    final http.Response response = await Network().postData(
        {'user_id': widget.userId, 'list_type': 'appointments'},
        '/getLists.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      _loading = false;
      var res = jsonDecode(response.body);
      setState(() {
        _appointments = res['appointmentList'];
      });
    });

    print(_appointments);

    return response;
  }

  // adding a new appointment
  Future<http.Response> _addDriver() async {
    setState(() {
      _loading = true;
    });

    final http.Response response = await Network().postData({
      'name': _nameController.text,
      'licenseNumber': _licenseController.text,
      'contact': _contactController.text
    }, '/addNewDriver.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      _loading = false;
    });

    return response;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Appointments'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewDriverDialog(context);
        },
        child: Icon(Icons.person_add),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: height,
              child: _appointments.length > 0
                  ? SingleChildScrollView(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          _getAppointments();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          height: height * 0.85,
                          width: double.infinity,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: _appointments.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.all(20),
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  width: width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(colors: [
                                      Color(0xFFDE6CF5),
                                      Color(0xFFCC79F2),
                                      Color(0xFFC77AF2),
                                      Color(0xFFBF7BF2),
                                      Color(0xFFB77CF3),
                                      Color(0xFFAD7DF3),
                                      Color(0xFF9F7EF4),
                                    ]),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3)),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _appointments[index]['full_name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: colorWhite),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: _appointments[index][
                                                            'appointment_status'] ==
                                                        'PENDING'
                                                    ? Colors.orange
                                                    : _appointments[index][
                                                                'appointment_status'] ==
                                                            'ACCEPTED'
                                                        ? Colors.green
                                                        : _appointments[index][
                                                                    'appointment_status'] ==
                                                                'COMPLETED'
                                                            ? Colors.blue[700]
                                                            : Colors.red[600]),
                                            child: Text(
                                              _appointments[index]
                                                  ['appointment_status'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Container(
                                            width: width - 80,
                                            height: 50,
                                            child: Text(
                                              _appointments[index]
                                                  ['description'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              style:
                                                  TextStyle(color: colorWhite),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      (_appointments[index]['date'] == null ||
                                              _appointments[index]['time'] ==
                                                  null)
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                  Text(
                                                    'Appointment: ',
                                                    style: TextStyle(
                                                        color: Colors.white70,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    'N/A',
                                                    style: TextStyle(
                                                        color: Colors.white70,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ])
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Appointment: ',
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  _appointments[index]['date'],
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  _appointments[index]['time'],
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    )
                  : Center(
                      child: Text('No appointment data found!'),
                    ),
            ),
    );
  }

// adding new user dialog
  Future<Widget> _addNewDriverDialog(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.transparent,
            child: Container(
              height: 370,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16),
              ),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    height: 70,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text('Add New User',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white),
                        textAlign: TextAlign.center),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          MyTextField(
                            hint: 'Full Name',
                            icon: MaterialCommunityIcons.account,
                            controller: _nameController,
                            validation: (val) {
                              if (val.isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                          ),
                          MyTextField(
                            hint: 'License Number',
                            icon: MaterialCommunityIcons.card_text,
                            controller: _licenseController,
                            validation: (val) {
                              if (val.isEmpty) {
                                return 'License number is required';
                              }
                              return null;
                            },
                          ),
                          MyTextField(
                            maxLength: 10,
                            hint: 'Contact Number',
                            icon: MaterialCommunityIcons.contact_phone,
                            isNumber: true,
                            controller: _contactController,
                            validation: (val) {
                              if (val.isEmpty) {
                                return 'Contact number is required';
                              }
                              return null;
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                _addDriver().then((value) {
                                  var res = jsonDecode(value.body);

                                  if (res['error'] == true) {
                                    Fluttertoast.showToast(
                                        msg: res['message'],
                                        backgroundColor: Colors.red[600],
                                        textColor: Colors.white,
                                        toastLength: Toast.LENGTH_LONG);
                                  } else {
                                    setState(() {
                                      _nameController.clear();
                                      _licenseController.clear();
                                      _contactController.clear();
                                    });
                                    Fluttertoast.showToast(
                                            msg: res['message'],
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            toastLength: Toast.LENGTH_LONG)
                                        .then((value) {
                                      Navigator.pop(context);
                                      _getAppointments();
                                    });
                                  }
                                });
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 30.0,
                              width: double.infinity,
                              child: Text(
                                'SAVE',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
