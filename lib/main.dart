import 'package:doctors/repositories/doctor_repository.dart';
import 'package:doctors/screens/doctor_details_screen.dart';
import 'package:doctors/screens/home_screen.dart';
import 'package:doctors/shared/theme/app_theme.dart';
import 'package:doctors/state/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final doctorRepository = DoctorRepository();
  runApp(AppScreen(doctorRepository: doctorRepository));
}

class AppScreen extends StatelessWidget {
  final DoctorRepository doctorRepository;

  const AppScreen({super.key, required this.doctorRepository});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: doctorRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(doctorRepository: doctorRepository)..add(LoadHomeEvent()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: const AppTheme().themeData,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
