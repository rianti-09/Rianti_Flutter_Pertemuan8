import 'package:flutter/material.dart';

class RadiobuttonPage extends StatefulWidget {
  const RadiobuttonPage({super.key});

  @override
  State<RadiobuttonPage> createState() => _RadiobuttonPageState();
}

class _RadiobuttonPageState extends State<RadiobuttonPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _umurController = TextEditingController();

  String? _gender;
  String? _job;
  String? _workType;

  final List<String> jobs = [
    "Admin",
    "Guru",
    "Programmer",
    "Pengusaha",
    "Desainer",
  ];

  final List<String> workTypes = [
    "Full Time",
    "Part Time",
    "Freelance",
    "Kontrak",
  ];

  final mainGradient = const LinearGradient(
    colors: [Color(0xFF00695C), Color(0xFF00BFA5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  Widget section(String title, Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget genderCard(String title, IconData icon) {
    final selected = _gender == title;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _gender = title),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: selected ? mainGradient : null,
            color: selected ? null : Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icon, color: selected ? Colors.white : Colors.grey[700]),
              const SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate() &&
        _gender != null &&
        _job != null &&
        _workType != null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("🎉 Berhasil"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Nama: ${_nameController.text}"),
              Text("Umur: ${_umurController.text}"),
              Text("Gender: $_gender"),
              Text("Job: $_job"),
              Text("Tipe: $_workType"),
            ],
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Lengkapi semua data")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Modern"),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: mainGradient),
        ),
      ),
      backgroundColor: const Color(0xFFF2F5F7),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            /// DATA DIRI
            section(
              "Data Diri",
              Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Nama",
                      prefixIcon: const Icon(Icons.person),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _umurController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Umur",
                      prefixIcon: const Icon(Icons.cake),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
                  ),
                ],
              ),
            ),

            /// GENDER
            section(
              "Jenis Kelamin",
              Row(
                children: [
                  genderCard("Laki-laki", Icons.male),
                  const SizedBox(width: 10),
                  genderCard("Perempuan", Icons.female),
                ],
              ),
            ),

            /// JOB
            section(
              "Pekerjaan",
              Wrap(
                spacing: 8,
                children: jobs.map((job) {
                  final selected = _job == job;
                  return ChoiceChip(
                    label: Text(job),
                    selected: selected,
                    selectedColor: const Color(0xFF00BFA5),
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : Colors.black,
                    ),
                    onSelected: (val) =>
                        setState(() => _job = val ? job : null),
                  );
                }).toList(),
              ),
            ),

            /// WORK TYPE
            section(
              "Tipe Pekerjaan",
              Column(
                children: workTypes.map((wt) {
                  return RadioListTile(
                    value: wt,
                    groupValue: _workType,
                    activeColor: const Color(0xFF00897B),
                    title: Text(wt),
                    onChanged: (val) =>
                        setState(() => _workType = val.toString()),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 10),

            /// BUTTON
            Container(
              decoration: BoxDecoration(
                gradient: mainGradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
