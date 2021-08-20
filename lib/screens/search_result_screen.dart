import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/custom_card.dart';
import '../models/gst.dart';

class SearchResultScreen extends StatefulWidget {
  final gstNumber;
  SearchResultScreen(this.gstNumber);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late Future<Gst> futureGst;

  @override
  void initState() {
    super.initState();
    futureGst = getGst(widget.gstNumber);
  }

  Future<Gst> getGst(gstNumber) async {
    final response = await http.get(Uri.parse(
        'https://611ea1889771bf001785c58e.mockapi.io/gst/' + gstNumber));
    if (response.statusCode == 200) {
      return Gst.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GST Profile'),
      ),
      body: FutureBuilder<Gst>(
        future: futureGst,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 16.0,
                        bottom: 8.0,
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'GSTIN of the Tax Payer',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            snapshot.data!.gstNumber,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(snapshot.data!.name),
                          SizedBox(height: 8),
                          Chip(
                            avatar: Icon(
                              Icons.fiber_manual_record,
                              size: 12,
                              color: Colors.white,
                            ),
                            label: Text(
                              snapshot.data!.status,
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: snapshot.data!.status == 'Active'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  CustomCard(
                    title: 'Address',
                    value: snapshot.data!.address,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomCard(
                          title: 'Tax Payer Type',
                          value: snapshot.data!.payerType,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: CustomCard(
                          title: 'Business Type',
                          value: snapshot.data!.businessType,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    child: CustomCard(
                      title: 'Date of Registration',
                      value: snapshot.data!.registrationDate,
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('No GSTIN Tax Payer Found!'),
            );
          }

          return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }
}
