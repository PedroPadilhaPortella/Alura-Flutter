import 'package:bytebank/models/name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BlocContainer extends StatelessWidget {
  const BlocContainer({Key? key}) : super(key: key);
}

void push(BuildContext blocContext, Function onClick) {
  // Navigator.of(blocContext).push(
  //   MaterialPageRoute(builder: (context) => container),
  // );

  Navigator.of(blocContext).push(
    MaterialPageRoute(
      builder: (ctx) => BlocProvider.value(
        value: BlocProvider.of<NameCubit>(blocContext),
        child: onClick(),
      ),
    ),
  );
}
