import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_management_system/constants/colors.dart';
import 'package:hospital_management_system/services/PaymentService.dart';
import 'package:http/http.dart' as http;
import 'package:hospital_management_system/services/NetworkHelper.dart';
import 'package:hospital_management_system/widgets/MyTextField.dart';

class LabTests extends StatefulWidget {
  final String userId;

  LabTests({this.userId});

  @override
  _LabTestsState createState() => _LabTestsState();
}

class _LabTestsState extends State<LabTests> {
  bool _loading = false;
  List _labTests;
  double width;
  double height;
  String dropdownValue = 'Update';

  TextEditingController _detailsController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    _getLabTests();
    super.initState();
  }

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

// get the lab test list
  Future<http.Response> _getLabTests() async {
    setState(() {
      _loading = true;
    });

    final http.Response response = await Network().postData(
        {'user_id': widget.userId, 'list_type': 'ongoing_lab_tests'},
        '/getLists.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      _loading = false;
      var res = jsonDecode(response.body);
      setState(() {
        _labTests = res['labTestList'];
      });
    });

    print(_labTests);

    return response;
  }

  // adding a new lab test request
  Future<http.Response> _addLabTest(stripeCustomerId) async {
    setState(() {
      _loading = true;
    });

    final http.Response response = await Network().postData({
      'payment_for': 'LAB_TEST',
      'patient_id': widget.userId.toString(),
      'amount': '700000',
      'details': _detailsController.text,
      'stripe_customer_id': stripeCustomerId
    }, '/charge.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      _loading = false;
    });

    return response;
  }

  // updating a lab test request
  Future<http.Response> _updateLabTest(labTestId) async {
    setState(() {
      _loading = true;
    });

    final http.Response response = await Network().postData({
      'lab_test_id': labTestId.toString(),
      'details': _detailsController.text
    }, '/updateLabTest.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      _loading = false;
    });

    return response;
  }

  // cancelling a lab test
  Future<http.Response> _cancelLabTest(labTestId) async {
    setState(() {
      _loading = true;
    });

    final http.Response response = await Network().postData({
      'test_id': labTestId.toString(),
    }, '/cancelLabTest.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      _loading = false;
    });

    return response;
  }

  // make poyment
  Future<StripeTransactionResponse> _makePayment() async {
    setState(() {
      _loading = true;
    });

    final response = await StripeService.payWithNewCard(
        amount: '700000', currency: 'lkr', paymentFor: 'LAB_TEST');

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Lab Tests'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('New Lab Test'),
        onPressed: () {
          _addNewLabTestDialog(context);
        },
        icon: Icon(FlutterIcons.lab_flask_ent),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: height,
              child: _labTests.length > 0
                  ? SingleChildScrollView(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          _getLabTests();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          height: height * 0.85,
                          width: double.infinity,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: _labTests.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 6),
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  width: width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colorWhite,
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
                                          RichText(
                                            text: TextSpan(
                                                text: 'Lab Test ID: ',
                                                style:
                                                    DefaultTextStyle.of(context)
                                                        .style,
                                                children: [
                                                  TextSpan(
                                                    text: _labTests[index]
                                                            ['test_id']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ]),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: _labTests[index]
                                                            ['test_status'] ==
                                                        'ACCEPTED'
                                                    ? Colors.green
                                                    : _labTests[index][
                                                                'test_status'] ==
                                                            'PAID'
                                                        ? Colors.blue[700]
                                                        : _labTests[index][
                                                                    'test_status'] ==
                                                                'COMPLETED'
                                                            ? Colors.grey[600]
                                                            : Colors.redAccent[
                                                                100]),
                                            child: Text(
                                              _labTests[index]['test_status'],
                                              style: TextStyle(
                                                  color: colorWhite,
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
                                              _labTests[index]['details'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Appointment: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          _labTests[index]['date'] == null
                                              ? Text(
                                                  'N/A',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              : Text(
                                                  _labTests[index]['date'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: DropdownButton<String>(
                                              isDense: true,
                                              isExpanded: true,
                                              icon: Icon(
                                                Icons.more_horiz,
                                              ),
                                              underline: Container(
                                                height: 0,
                                                color: Colors.deepPurpleAccent,
                                              ),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  dropdownValue = newValue;
                                                });
                                              },
                                              items: <String>[
                                                'View',
                                                'Update',
                                                'Cancel'
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                  onTap: () {
                                                    print(value);
                                                    print(_labTests[index]);

                                                    if (value == 'View') {
                                                      _viewLabTestDialog(
                                                          context,
                                                          _labTests[index]);
                                                    } else if (value ==
                                                            'Cancel' ||
                                                        value == 'Update') {
                                                      if (_labTests[index][
                                                                  'test_status'] ==
                                                              'CANCELLED' ||
                                                          _labTests[index][
                                                                  'test_status'] ==
                                                              'COMPLETED') {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                'This lab test has already been ${_labTests[index]['test_status']}!',
                                                            backgroundColor:
                                                                Colors.red[600],
                                                            textColor:
                                                                colorWhite,
                                                            toastLength: Toast
                                                                .LENGTH_LONG);
                                                      } else {
                                                        if (value == 'Cancel') {
                                                          _cancelLabTest(
                                                                  _labTests[
                                                                          index]
                                                                      [
                                                                      'test_id'])
                                                              .then((value) {
                                                            var res =
                                                                jsonDecode(
                                                                    value.body);

                                                            if (res['error'] ==
                                                                true) {
                                                              Fluttertoast.showToast(
                                                                  msg: res[
                                                                      'message'],
                                                                  backgroundColor:
                                                                      Colors.red[
                                                                          600],
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  toastLength: Toast
                                                                      .LENGTH_LONG);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                      msg: res[
                                                                          'message'],
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green,
                                                                      textColor:
                                                                          Colors
                                                                              .white,
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_LONG)
                                                                  .then(
                                                                      (value) {
                                                                _getLabTests();
                                                              });
                                                            }
                                                          });
                                                        } else if (value ==
                                                            'Update') {
                                                          _updateLabTestDialog(
                                                              context,
                                                              _labTests[index]
                                                                  ['test_id']);
                                                        }
                                                      }
                                                    }
                                                  },
                                                );
                                              }).toList(),
                                            ),
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
                      child: Text('No lab tests found!'),
                    ),
            ),
    );
  }

// add new lab test dialog
  Future<Widget> _addNewLabTestDialog(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.transparent,
            child: Container(
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
                    child: Text('New Lab Test',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: colorWhite),
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
                            hint: 'Details',
                            icon: MaterialCommunityIcons.note_text,
                            isMultiline: true,
                            maxLines: 5,
                            controller: _detailsController,
                            validation: (val) {
                              if (val.isEmpty) {
                                return 'Details are required';
                              }
                              return null;
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                Navigator.pop(context);

                                _makePayment().then((value) {
                                  if (value.success == true) {
                                    _addLabTest(value.paymentId).then((val) {
                                      var res = jsonDecode(val.body);

                                      if (res['error'] == true) {
                                        Fluttertoast.showToast(
                                            msg: res['message'],
                                            backgroundColor: Colors.red[600],
                                            textColor: colorWhite,
                                            toastLength: Toast.LENGTH_LONG);
                                      } else {
                                        Fluttertoast.showToast(
                                                msg: res['message'],
                                                backgroundColor: Colors.green,
                                                textColor: colorWhite,
                                                toastLength: Toast.LENGTH_LONG)
                                            .then((value) {
                                          setState(() {
                                            _detailsController.clear();
                                          });
                                          _getLabTests();
                                        });
                                      }
                                    });
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: value.message,
                                        backgroundColor: Colors.red[600],
                                        textColor: colorWhite,
                                        toastLength: Toast.LENGTH_LONG);
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
                    height: 8,
                  ),
                ],
              ),
            ),
          );
        });
  }

  // update lab test dialog
  Future<Widget> _updateLabTestDialog(context, labTestId) async {
    await Future.delayed(Duration(milliseconds: 100));
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.transparent,
            child: Container(
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
                    child: Text('Update Lab Test Details',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: colorWhite),
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
                            hint: 'Details',
                            icon: MaterialCommunityIcons.note_text,
                            isMultiline: true,
                            maxLines: 5,
                            controller: _detailsController,
                            validation: (val) {
                              if (val.isEmpty) {
                                return 'The details are required';
                              }
                              return null;
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                _updateLabTest(labTestId).then((value) {
                                  var res = jsonDecode(value.body);

                                  if (res['error'] == true) {
                                    Fluttertoast.showToast(
                                        msg: res['message'],
                                        backgroundColor: Colors.red[600],
                                        textColor: colorWhite,
                                        toastLength: Toast.LENGTH_LONG);
                                  } else {
                                    setState(() {
                                      _detailsController.clear();
                                    });
                                    Fluttertoast.showToast(
                                            msg: res['message'],
                                            backgroundColor: Colors.green,
                                            textColor: colorWhite,
                                            toastLength: Toast.LENGTH_LONG)
                                        .then((value) {
                                      Navigator.pop(context);
                                      _getLabTests();
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
                    height: 8,
                  ),
                ],
              ),
            ),
          );
        });
  }

  // view lab test details dialog
  Future<Widget> _viewLabTestDialog(context, labTest) async {
    await Future.delayed(Duration(milliseconds: 100));
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.transparent,
            child: Container(
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
                    child: Text('Lab Test Details',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: colorWhite),
                        textAlign: TextAlign.center),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 200,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Details:',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            Text(labTest['details']),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'Date: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                Text(labTest['date'] != null
                                    ? labTest['date']
                                    : 'N/A')
                              ],
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 30.0,
                      width: double.infinity,
                      child: Text(
                        'CLOSE',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
