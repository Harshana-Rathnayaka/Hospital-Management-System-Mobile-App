import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_management_system/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:hospital_management_system/services/NetworkHelper.dart';

class Prescriptions extends StatefulWidget {
  final String userId;

  Prescriptions({this.userId});

  @override
  _PrescriptionsState createState() => _PrescriptionsState();
}

class _PrescriptionsState extends State<Prescriptions> {
  bool _loading = false;
  List _prescriptions;
  double width;
  double height;
  String dropdownValue = 'Mark as Received';


  @override
  void initState() {
    _getPrescriptions();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

// get the prescriptions list
  Future<http.Response> _getPrescriptions() async {
    setState(() {
      _loading = true;
    });

    final http.Response response = await Network().postData(
        {'user_id': widget.userId, 'list_type': 'prescriptions'},
        '/getLists.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      _loading = false;
      var res = jsonDecode(response.body);
      setState(() {
        _prescriptions = res['prescriptionList'];
      });
    });

    print(_prescriptions);

    return response;
  }

  // marking a prescription as received
  Future<http.Response> _markAsReceived(prescriptionId) async {
    setState(() {
      _loading = true;
    });

    final http.Response response = await Network().postData({
      'prescription_id': prescriptionId.toString(),
    }, '/markAsReceived.php');

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Prescriptions'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: height,
              child: _prescriptions.length > 0
                  ? SingleChildScrollView(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          _getPrescriptions();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          height: height * 0.85,
                          width: double.infinity,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: _prescriptions.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      20, 10, 20, 6),
                                  margin: const EdgeInsets.fromLTRB(
                                      20, 10, 20, 10),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                text: 'Prescription ID: ',
                                                style: DefaultTextStyle.of(
                                                        context)
                                                    .style,
                                                children: [
                                                  TextSpan(
                                                    text: _prescriptions[
                                                                index][
                                                            'prescription_id']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ]),
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 2,
                                                    horizontal: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: _prescriptions[index][
                                                            'prescription_status'] ==
                                                        'PENDING'
                                                    ? Colors.orange
                                                    : _prescriptions[index][
                                                                'prescription_status'] ==
                                                            'SHIPPED'
                                                        ? Colors.green
                                                        : _prescriptions[
                                                                        index]
                                                                    [
                                                                    'prescription_status'] ==
                                                                'RECEIVED'
                                                            ? Colors.blue[700]
                                                            : Colors
                                                                .grey[600]),
                                            child: Text(
                                              _prescriptions[index]
                                                  ['prescription_status'],
                                              style: TextStyle(
                                                  color: colorWhite,
                                                  fontWeight:
                                                      FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Prescription:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Container(
                                        width: width - 80,
                                        height: 55,
                                        child: Text(
                                          _prescriptions[index]
                                                  ['prescription']
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Location:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Container(
                                        width: width - 80,
                                        height: 40,
                                        child: Text(
                                          _prescriptions[index]
                                              ['prescription_location'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: DropdownButton<String>(
                                              isDense: true,
                                              isExpanded: true,
                                              icon: Icon(Icons.more_horiz),
                                              underline: Container(
                                                height: 0,
                                                color:
                                                    Colors.deepPurpleAccent,
                                              ),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  dropdownValue = newValue;
                                                });
                                              },
                                              items: <String>[
                                                'Mark as Received',
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<
                                                    String>(
                                                  value: value,
                                                  child: Text(value),
                                                  onTap: () {
                                                    print(value);
                                                    print(_prescriptions[
                                                        index]);

                                                    _markAsReceived(
                                                            _prescriptions[
                                                                    index][
                                                                'prescription_id'])
                                                        .then((value) {
                                                      var res = jsonDecode(
                                                          value.body);

                                                      if (res['error'] ==
                                                          true) {
                                                        Fluttertoast.showToast(
                                                            msg: res[
                                                                'message'],
                                                            backgroundColor:
                                                                Colors
                                                                    .red[600],
                                                            textColor:
                                                                colorWhite,
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
                                                                    colorWhite,
                                                                toastLength: Toast
                                                                    .LENGTH_LONG)
                                                            .then((value) {
                                                          _getPrescriptions();
                                                        });
                                                      }
                                                    });
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
                      child: Text('No prescriptions found!'),
                    ),
            ),
    );
  }
}
