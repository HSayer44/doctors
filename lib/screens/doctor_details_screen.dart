import 'package:doctors/repositories/doctor_repository.dart';
import 'package:doctors/shared/utils/time_of_day_extensions.dart';
import 'package:doctors/state/doctor_details/doctor_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';

import '../shared/widgets/buttons/app_icon_button.dart';
import '../shared/widgets/cards/doctor_card.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final String doctorId;

  const DoctorDetailsScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorDetailsBloc(
        doctorRepository: context.read<DoctorRepository>(),
      )..add(LoadDoctorDetailsEvent(doctorId: doctorId)),
      child: const DoctorDetailsView(),
    );
  }
}

class DoctorDetailsView extends StatelessWidget {
  const DoctorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          'Doctor Details',
          style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          AppIconButton(
            icon: Icons.favorite_outline,
            onTap: () {},
          )
        ],
      ),
      body: BlocBuilder<DoctorDetailsBloc, DoctorDetailsState>(
        builder: (context, state) {
          if (state.status == DoctorDetailsStatus.initial ||
              state.status == DoctorDetailsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == DoctorDetailsStatus.loaded) {
            final doctor = state.doctor;

            if (doctor == null) {
              return const Center(child: Text('Doctor not found.'));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DoctorCard(doctor: state.doctor!),
                  Divider(height: 32.0, color: colorScheme.surfaceVariant),
                  _DoctorWorkingHours(workingHours: doctor.workingHours),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
class _DoctorWorkingHours extends StatelessWidget {
  final List<DoctorWorkingHours> workingHours;
  const _DoctorWorkingHours({super.key, required this.workingHours});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Working Hours', style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ListView.separated(
          padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: Doctor.sampleDoctors[0].workingHours.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: Text(workingHours[index].dayOfWeek),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.surfaceVariant),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                   workingHours[index].startTime.toCustomString(),
                    style: textTheme.bodySmall!.copyWith(color: colorScheme.onBackground.withOpacity(.5)),
                  ),
                ),
                const SizedBox(width: 16),
                const Text('-'),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.surfaceVariant),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    workingHours[index].endTime.toCustomString(),
                    style: textTheme.bodySmall!.copyWith(color: colorScheme.onBackground.withOpacity(.5)),
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
