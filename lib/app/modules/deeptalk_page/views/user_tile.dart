import 'package:flutter/material.dart';
import 'package:save_me_new/component/GlobalFunction.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2.0,
        color: PRIMARY_COLOR,
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              const Icon(
                Icons.person,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
