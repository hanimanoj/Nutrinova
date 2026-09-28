import 'package:flutter/material.dart';

import '../models/patient.dart';

class PatientFormPage extends StatefulWidget {
  const PatientFormPage({super.key});

  @override
  State<PatientFormPage> createState() => _PatientFormPageState();
}

class _PatientFormPageState extends State<PatientFormPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final patientIdController = TextEditingController();
  final admissionDateController = TextEditingController();
  final bedController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  final picController = TextEditingController(
    text: 'Dr. Siti',
  );

  String? selectedGender;
  bool activeStatus = true;

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    patientIdController.dispose();
    admissionDateController.dispose();
    bedController.dispose();
    heightController.dispose();
    weightController.dispose();
    picController.dispose();

    super.dispose();
  }

  // ==========================================================
  // DATE PICKER
  // ==========================================================

  Future<void> _selectDate(
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        controller.text =
            '${picked.day.toString().padLeft(2, '0')}/'
            '${picked.month.toString().padLeft(2, '0')}/'
            '${picked.year}';
      });
    }
  }

  // ==========================================================
  // RESET
  // ==========================================================

  void _resetForm() {
    nameController.clear();
    dobController.clear();
    patientIdController.clear();
    admissionDateController.clear();
    bedController.clear();
    heightController.clear();
    weightController.clear();

    picController.text = 'Dr. Siti';

    setState(() {
      selectedGender = null;
      activeStatus = true;
    });
  }

  // ==========================================================
  // ADD PATIENT
  // ==========================================================

  void _submitPatient() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final patient = Patient(
      name: nameController.text,
      patientId: patientIdController.text,
      bedNumber: bedController.text,
      dateOfBirth: dobController.text,
      admissionDate: admissionDateController.text,
      gender: selectedGender!,
      height: heightController.text,
      weight: weightController.text,
      personInCharge: picController.text,
      active: activeStatus,
    );

    Navigator.pop(context, patient);
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8FBE5),

      body: SafeArea(
        child: Column(
          children: [
            _buildTopHeader(),

            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(
                    24,
                    4,
                    24,
                    20,
                  ),
                  padding: const EdgeInsets.fromLTRB(
                    45,
                    18,
                    45,
                    25,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFD0E5CC),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTitle(),

                        const SizedBox(height: 25),

                        LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth > 650) {
                              return _buildDesktopForm();
                            }

                            return _buildMobileForm();
                          },
                        ),

                        const SizedBox(height: 30),

                        _buildButtons(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // HEADER
  // ==========================================================

  Widget _buildTopHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      child: Row(
        children: [
          const Spacer(),

          Container(
            width: 38,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          const SizedBox(width: 12),

          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blue.shade200,
              ),
            ),
            child: Icon(
              Icons.monitor_heart_outlined,
              size: 18,
              color: Colors.blue.shade300,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // TITLE
  // ==========================================================

  Widget _buildTitle() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.grey,
          ),
        ),

        const Expanded(
          child: Center(
            child: Text(
              'Patient Form',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(width: 48),
      ],
    );
  }

  // ==========================================================
  // DESKTOP FORM
  // ==========================================================

  Widget _buildDesktopForm() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _textField(
                'Name *',
                nameController,
              ),
            ),
            const SizedBox(width: 25),
            Expanded(
              child: _dateField(
                'Date of Birth *',
                dobController,
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        Row(
          children: [
            Expanded(
              child: _textField(
                'Patient ID *',
                patientIdController,
              ),
            ),
            const SizedBox(width: 25),
            Expanded(
              child: _dateField(
                'Admission Date *',
                admissionDateController,
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        Row(
          children: [
            Expanded(
              child: _genderField(),
            ),
            const SizedBox(width: 25),
            Expanded(
              child: _textField(
                'Bed Number *',
                bedController,
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        Row(
          children: [
            Expanded(
              child: _textField(
                'Height (cm) *',
                heightController,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 25),
            Expanded(
              child: _textField(
                'Weight (kg) *',
                weightController,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        Row(
          children: [
            Expanded(
              child: _textField(
                'Person in Charge (PIC)',
                picController,
              ),
            ),
            const SizedBox(width: 25),
            Expanded(
              child: _patientStatus(),
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================================
  // MOBILE FORM
  // ==========================================================

  Widget _buildMobileForm() {
    return Column(
      children: [
        _textField('Name *', nameController),
        _dateField('Date of Birth *', dobController),
        _textField('Patient ID *', patientIdController),
        _dateField(
          'Admission Date *',
          admissionDateController,
        ),
        _genderField(),
        _textField('Bed Number *', bedController),
        _textField(
          'Height (cm) *',
          heightController,
          keyboardType: TextInputType.number,
        ),
        _textField(
          'Weight (kg) *',
          weightController,
          keyboardType: TextInputType.number,
        ),
        _textField(
          'Person in Charge (PIC)',
          picController,
        ),
        _patientStatus(),
      ],
    );
  }

  // ==========================================================
  // TEXT FIELD
  // ==========================================================

  Widget _textField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 6),

        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: (value) {
            if (label.contains('*') &&
                (value == null || value.trim().isEmpty)) {
              return 'Required';
            }

            return null;
          },
          decoration: _inputDecoration(),
        ),
      ],
    );
  }

  // ==========================================================
  // DATE FIELD
  // ==========================================================

  Widget _dateField(
    String label,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 6),

        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: () => _selectDate(controller),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }

            return null;
          },
          decoration: _inputDecoration(
            hintText: 'dd/mm/yyyy',
            suffixIcon: const Icon(
              Icons.calendar_month_outlined,
              size: 19,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // GENDER
  // ==========================================================

  Widget _genderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender *',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 6),

        DropdownButtonFormField<String>(
          value: selectedGender,
          validator: (value) {
            if (value == null) {
              return 'Required';
            }

            return null;
          },
          decoration: _inputDecoration(),
          items: const [
            DropdownMenuItem(
              value: 'Male',
              child: Text('Male'),
            ),
            DropdownMenuItem(
              value: 'Female',
              child: Text('Female'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              selectedGender = value;
            });
          },
        ),
      ],
    );
  }

  // ==========================================================
  // PATIENT STATUS
  // ==========================================================

  Widget _patientStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Patient Status *',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 14),

        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  activeStatus = true;
                });
              },
              child: Row(
                children: [
                  _statusDot(activeStatus),
                  const SizedBox(width: 6),
                  const Text(
                    'Active',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 20),

            GestureDetector(
              onTap: () {
                setState(() {
                  activeStatus = false;
                });
              },
              child: Row(
                children: [
                  _statusDot(!activeStatus),
                  const SizedBox(width: 6),
                  const Text(
                    'Discharged',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _statusDot(bool selected) {
    return Container(
      width: 13,
      height: 13,
      decoration: BoxDecoration(
        color: selected
            ? const Color(0xFF65C58A)
            : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }

  // ==========================================================
  // INPUT DECORATION
  // ==========================================================

  InputDecoration _inputDecoration({
    String? hintText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: Colors.green,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 13,
      ),
    );
  }

  // ==========================================================
  // BUTTONS
  // ==========================================================

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 110,
          height: 42,
          child: ElevatedButton(
            onPressed: _resetForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text('Reset'),
          ),
        ),

        const SizedBox(width: 18),

        SizedBox(
          width: 120,
          height: 42,
          child: ElevatedButton(
            onPressed: _submitPatient,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF27D500),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text('Add Patient'),
          ),
        ),
      ],
    );
  }
}