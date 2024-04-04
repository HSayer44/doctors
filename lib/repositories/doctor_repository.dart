import 'package:models/models.dart';

class DoctorRepository {
  const DoctorRepository(
      //TODO: inject required dependencies
      //e.g. class to connect with the db
      );

  Future<List<DoctorCategory>> fetchDoctorCategories() async {
  await Future.delayed(const Duration(milliseconds: 1000));
  //TODO: get those data from the db
  return DoctorCategory.values;
  }

  Future<List<Doctor>> fetchDoctors() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return Doctor.sampleDoctors;
  }

  Future<List<Doctor>> fetchDoctorsByCategories(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    throw UnimplementedError();
  }

  Future<Doctor?> fetchDoctorByID(String doctorId) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return Doctor.sampleDoctors.firstWhere((doctor) => doctor.id == doctorId);
  }
}