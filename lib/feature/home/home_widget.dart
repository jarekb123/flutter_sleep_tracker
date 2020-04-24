import 'package:flutter/material.dart';
import 'package:sleeptracker/shared_widgets/buttons.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Get to know your baby\'s sleep patterns and keep track of how much sleep they are getting here.',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            PrimaryButton(
              onPressed: () {},
              child: const Text('Add new sleeping record'),
            )
          ],
        ),
      ),
    );
  }
}
