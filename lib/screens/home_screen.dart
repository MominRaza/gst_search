import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String gstNumber = '';
  late String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GST Number Search Tool'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                bottom: 8.0,
              ),
              child: Text('Enter GST Number'),
            ),
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                hintText: 'Ex: 07AACCM9910C1ZP',
                filled: true,
              ),
              onChanged: (value) {
                gstNumber = value.trim();
              },
            ),
            SizedBox(height: 8.0),
            error != ''
                ? Text(
                    error,
                    style: TextStyle(color: Colors.red[600]),
                  )
                : Text(''),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (gstNumber.length != 15) {
                    setState(() {
                      error = "GST Number should be 15 charecture!";
                    });
                    return;
                  }
                  setState(() {
                    error = "";
                  });
                  Navigator.of(context).pushNamed(
                    '/search_result',
                    arguments: gstNumber,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                  ),
                  child: Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
