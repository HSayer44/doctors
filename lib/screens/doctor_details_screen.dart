import 'package:doctors/shared/utils/time_of_day_extensions.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';

import '../shared/widgets/buttons/app_icon_button.dart';
import '../shared/widgets/cards/doctor_card.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final String doctorId;

  const DoctorDetailsScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    //bloc here
    return const DoctorDetailsView();
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DoctorCard(doctor: Doctor.sampleDoctors[0]),
            Divider(height: 32, color: colorScheme.surfaceVariant),
            const _DoctorWorkingHours(),
          ],
        ),
      ),
    );
  }
}

class _DoctorWorkingHours extends StatelessWidget {
  const _DoctorWorkingHours({super.key});

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
                  child: Text(Doctor.sampleDoctors[0].workingHours[index].dayOfWeek),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.surfaceVariant),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    Doctor.sampleDoctors[0].workingHours[index].startTime.toCustomString(),
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
                    Doctor.sampleDoctors[0].workingHours[index].endTime.toCustomString(),
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
