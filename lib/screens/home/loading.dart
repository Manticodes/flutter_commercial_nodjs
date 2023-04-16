import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool showError = false;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          showError = true;
          print(showError);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: CircularProgressIndicator()),
          if (showError)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                  child: Container(
                child: const Text('Take too long , pls check network'),
                margin: EdgeInsets.all(10),
              )),
            )
        ],
      ),
    );
  }
}
