import 'package:flutter/material.dart';

class AutocompleteSpinPage extends StatefulWidget {
  const AutocompleteSpinPage({super.key});

  @override
  State<AutocompleteSpinPage> createState() => _AutocompleteSpinPageState();
}

class _AutocompleteSpinPageState extends State<AutocompleteSpinPage> {
  final _formKey = GlobalKey<FormState>();

  // Controller
  final TextEditingController _universityController = TextEditingController();

  final TextEditingController _majorController = TextEditingController();

  // Selected Dropdown
  String? _selectedEducationLevel;
  String? _selectedYear;

  // Data Universitas
  final List<String> _universities = [
    'Universitas Indonesia',
    'Institut Teknologi Bandung',
    'Universitas Gadjah Mada',
    'Universitas Padjadjaran',
    'Universitas Airlangga',
    'Institut Pertanian Bogor',
    'Universitas Brawijaya',
    'Universitas Diponegoro',
    'Universitas Sebelas Maret',
    'Universitas Negeri Jakarta',
    'Universitas Pamulang',
  ];

  // Data Jurusan
  final List<String> _majors = [
    'Teknik Informatika',
    'Sistem Informasi',
    'Teknik Elektro',
    'Manajemen',
    'Akuntansi',
    'Hukum',
    'Kedokteran',
    'Psikologi',
    'Desain Komunikasi Visual',
    'Hubungan Internasional',
  ];

  // Data Jenjang
  final List<String> _educationLevels = [
    'SMA/Sederajat',
    'D3',
    'S1',
    'S2',
    'S3',
  ];

  // Data Tahun
  final List<String> _years = [
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        toolbarHeight: 90,
        centerTitle: true,
        title: const Text(
          "Pertemuan 8\nForm AutoComplete & Spinner",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            height: 1.5,
          ),
        ),
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // ================= UNIVERSITAS =================
              _buildAutocompleteField(
                label: 'Universitas',
                controller: _universityController,
                options: _universities,
                hint: 'Pilih universitas',
                icon: Icons.school,
                onSelected: (value) {
                  _universityController.text = value;
                },
              ),

              const SizedBox(height: 20),

              // ================= JURUSAN =================
              _buildAutocompleteField(
                label: 'Jurusan',
                controller: _majorController,
                options: _majors,
                hint: 'Pilih jurusan',
                icon: Icons.menu_book,
                onSelected: (value) {
                  _majorController.text = value;
                },
              ),

              const SizedBox(height: 20),

              // ================= JENJANG =================
              _buildDropdownField(
                label: 'Jenjang Pendidikan',
                value: _selectedEducationLevel,
                items: _educationLevels,
                hint: 'Pilih jenjang pendidikan',
                icon: Icons.timeline,
                onChanged: (value) {
                  setState(() {
                    _selectedEducationLevel = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              // ================= TAHUN =================
              _buildDropdownField(
                label: 'Tahun Masuk',
                value: _selectedYear,
                items: _years,
                hint: 'Pilih tahun masuk',
                icon: Icons.calendar_today,
                onChanged: (value) {
                  setState(() {
                    _selectedYear = value;
                  });
                },
              ),

              const SizedBox(height: 30),

              // ================= BUTTON =================
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ================= AUTOCOMPLETE =================

  Widget _buildAutocompleteField({
    required String label,
    required TextEditingController controller,
    required List<String> options,
    required String hint,
    required IconData icon,
    required Function(String) onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Row(
          children: [
            Icon(icon, color: Colors.deepPurple),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
                fontSize: 15,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Autocomplete
        Autocomplete<String>(
          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }

            return options.where(
              (option) => option.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              ),
            );
          },

          onSelected: onSelected,

          fieldViewBuilder:
              (context, fieldController, focusNode, onFieldSubmitted) {
                return TextFormField(
                  controller: fieldController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: hint,
                    filled: true,
                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.deepPurple,
                        width: 2,
                      ),
                    ),

                    suffixIcon: const Icon(
                      Icons.search,
                      color: Colors.deepPurple,
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan isi $label';
                    }
                    return null;
                  },
                );
              },
        ),
      ],
    );
  }

  // ================= DROPDOWN =================

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required String hint,
    required IconData icon,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Row(
          children: [
            Icon(icon, color: Colors.deepPurple),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
                fontSize: 15,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Dropdown
        DropdownButtonFormField<String>(
          value: value,
          hint: Text(hint),

          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
            ),
          ),

          items: items.map((item) {
            return DropdownMenuItem(value: item, child: Text(item));
          }).toList(),

          onChanged: onChanged,

          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Silakan pilih $label';
            }
            return null;
          },
        ),
      ],
    );
  }

  // ================= BUTTON =================

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _submitForm,

        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        child: const Text(
          "Simpan Data",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // ================= SUBMIT =================

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,

        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 10),
              Text("Berhasil"),
            ],
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Universitas', _universityController.text),

              _buildDetailRow('Jurusan', _majorController.text),

              _buildDetailRow('Jenjang', _selectedEducationLevel ?? ''),

              _buildDetailRow('Tahun', _selectedYear ?? ''),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _resetForm();
              },

              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  // ================= DETAIL =================

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),

      child: Row(
        children: [
          Text(
            "$label : ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  // ================= RESET =================

  void _resetForm() {
    setState(() {
      _universityController.clear();
      _majorController.clear();
      _selectedEducationLevel = null;
      _selectedYear = null;
    });
  }

  @override
  void dispose() {
    _universityController.dispose();
    _majorController.dispose();
    super.dispose();
  }
}
