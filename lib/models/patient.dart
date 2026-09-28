class Patient {
  final String name;
  final String patientId;
  final String bedNumber;
  final String dateOfBirth;
  final String admissionDate;
  final String gender;
  final String height;
  final String weight;
  final String personInCharge;
  final bool active;

  Patient({
    required this.name,
    required this.patientId,
    required this.bedNumber,
    required this.dateOfBirth,
    required this.admissionDate,
    required this.gender,
    required this.height,
    required this.weight,
    required this.personInCharge,
    required this.active,
  });
}