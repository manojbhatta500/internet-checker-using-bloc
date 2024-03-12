import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet/cubit/internet_cubit.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => InternetCubit(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late InternetCubit internetCubit;

  @override
  void initState() {
    internetCubit = context.read<InternetCubit>();
    internetCubit.checkConnectivity();
    internetCubit.trackChanges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: BlocBuilder<InternetCubit, InternetStatus>(
        builder: (context, state) {
          log("real deal");
          log(state.status.toString());
          if (state.status == ConnectivityStatus.connected) {
            return Scaffold(
              body: Center(child: Text("connected")),
            );
          } else {
            return Scaffold(
              body: Center(child: Text("disconnected")),
            );
          }
        },
      )),
    );
  }
}
