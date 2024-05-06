import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_dialerbutton_flutter/source/dialer_button.dart';

import '../gen/assets.gen.dart';

class InitialScreen extends StatelessWidget {
  final String title;
  static const String route = '/InitialScreen';

  const InitialScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: homeWidget(context),
      floatingActionButton: null,
    );
  }

  Widget homeWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              const snackBar = SnackBar(
                content: Text('🤣 That Tickles!'),
                duration: Duration(milliseconds: 500),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: SizedBox(
              width: 100,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Assets.images.phonedialer1024x1024.image(),
              ),
            ),
          ),
          const Gap(15.0),
          DialerButton(
            topWidget: const Text('1',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            bottomWidget: const Text('',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            diameter: 48.0,
            borderColor: Colors.deepPurple, // Example usage
            backgroundColor: Colors.black.withOpacity(0.1), // Example usage
            splashColor: Colors.green.withOpacity(0.1), // Example usage
            lineColor: Colors.green,

            onPressed: () {
              const snackBar = SnackBar(
                content: Text('🤣 That Tickles!'),
                duration: Duration(milliseconds: 500),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          const Gap(3.0),
          DialerButton(
            topWidget: const Text('#',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            bottomWidget: null,
            borderColor: Colors.purple,
            onPressed: () {
              const snackBar = SnackBar(
                content: Text('🤣 That Tickles!'),
                duration: Duration(milliseconds: 500),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          const Gap(3.0),
          DialerButton(
            topWidget: const Text(
              '2',
              style: TextStyle(fontSize: 24),
            ),
            bottomWidget: const Text('ABC',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            borderColor: Colors.purple,
            onPressed: () {
              const snackBar = SnackBar(
                content: Text('🤣 That Tickles!'),
                duration: Duration(milliseconds: 500),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      ),
    );
  }
}
