import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;

  const FloatingActionButtonWidget({
    Key? key,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.15,
        height: 50,
        margin: const EdgeInsets.only(
          bottom: 20.0,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: onTap == null ? Colors.grey : Theme.of(context).accentColor,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: onTap == null
                  ? Colors.grey
                  : Theme.of(context).accentColor.withOpacity(0.3),
              blurRadius: onTap == null ? 9.0 : 25.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
