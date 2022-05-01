import 'package:flutter/material.dart';

class DashboardButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onClick;

  const DashboardButton(
      {Key? key,
      required this.label,
      required this.icon,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => onClick(),
              ),
            );
          },
          child: SizedBox(
              height: 100,
              width: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.white,
                      size: 24,
                    ),
                    Text(
                      label,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
