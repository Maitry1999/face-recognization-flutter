import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'SuccessScreen')
class SuccessScreen extends StatefulWidget {
  final String message;
  final bool showWarning;
  const SuccessScreen(
      {super.key, required this.message, this.showWarning = false});

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();

    // Automatically go back after 2 seconds
    Future.delayed(const Duration(seconds: 3), () {
      context.router.popUntil(
        (route) => route.isFirst,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Success'),
      //   automaticallyImplyLeading: false, // Remove back button from the app bar
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.showWarning
                  ? Icons.dangerous_rounded
                  : Icons.check_circle_outline_rounded,
              color: widget.showWarning ? Colors.red : Colors.green,
              size: 100,
            ),
            const SizedBox(height: 20),
            Text(
              widget.message,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
