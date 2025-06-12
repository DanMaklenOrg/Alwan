import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key, required this.title, required this.icon, required this.progress, this.onTap}) : assert(progress >= 0 && progress <= 100);

  final String title;
  final IconData icon;
  final int progress;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          width: 75,
          margin: EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(icon), SizedBox(width: 4), Text('$progress%')],
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
