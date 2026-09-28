import 'package:flutter/material.dart';

import 'models/patient.dart';
import 'add_patient_form.dart';
import 'dashboard_page.dart';
import 'archive_page.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  final List<Patient> patients = [];

  Future<void> _addPatient() async {
    final Patient? newPatient = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PatientFormPage(),
      ),
    );

    if (newPatient != null) {
      setState(() {
        patients.add(newPatient);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8FBE5),
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(24, 4, 24, 20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFD0E5CC),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _buildMenu(),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          38,
                          18,
                          38,
                          20,
                        ),
                        child: Column(
                          children: [
                            _buildPageToolbar(),

                            const SizedBox(height: 4),

                            Expanded(
                              child: patients.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'No patients added yet.',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: patients.length,
                                      itemBuilder: (context, index) {
                                        return _buildPatientCard(
                                          patients[index],
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addPatient,
        backgroundColor: const Color(0xFF19B9D1),
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 34,
        ),
      ),
    );
  }

  Widget _buildMenu() {
    return Row(
      children: [
        _menuButton(
          'Dashboard',
          false,
          () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardPage(),
              ),
            );
          },
        ),

        _menuButton(
          'Patient',
          true,
          () {},
        ),

        _menuButton(
          'Archived',
          false,
          () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ArchivePage(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _menuButton(
    String title,
    bool selected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 17,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFE8FBE5)
              : Colors.transparent,
          border: Border(
            right: BorderSide(
              color: const Color(0xFFD0E5CC),
            ),
          ),
          borderRadius: selected
              ? const BorderRadius.only(
                  bottomRight: Radius.circular(12),
                )
              : BorderRadius.zero,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight:
                selected ? FontWeight.w600 : FontWeight.w400,
            color: selected
                ? const Color(0xFF444444)
                : Colors.grey,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // TOOLBAR
  // ==========================================================

  Widget _buildPageToolbar() {
    return Row(
      children: [
        const Text(
          'All',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),

        const Spacer(),

        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            size: 25,
          ),
        ),

        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.tune,
            size: 23,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // PATIENT CARD
  // ==========================================================

  Widget _buildPatientCard(Patient patient) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
              color: patient.active
                  ? const Color(0xFF32D100)
                  : Colors.red,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  'Patient ID : ${patient.patientId}',
                  style: const TextStyle(fontSize: 12),
                ),

                Text(
                  'Bed Number : ${patient.bedNumber}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Admission date : ${patient.admissionDate}',
                style: const TextStyle(fontSize: 9),
              ),

              const SizedBox(height: 8),

              if (patient.active)
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 6,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'Discharge',
                    style: TextStyle(fontSize: 14),
                  ),
                )
              else
                const Icon(
                  Icons.folder_open_outlined,
                  size: 22,
                ),
            ],
          ),
        ],
      ),
    );
  }
}