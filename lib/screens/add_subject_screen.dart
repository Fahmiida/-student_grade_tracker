import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subject_provider.dart';

class AddSubjectScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _markController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Subject'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Subject Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _markController,
                decoration: InputDecoration(
                  labelText: 'Mark (0-100)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a mark';
                  }
                  final mark = double.tryParse(value);
                  if (mark == null || mark < 0 || mark > 100) {
                    return 'Mark must be between 0 and 100';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final name = _nameController.text;
                    final mark = double.parse(_markController.text);
                    
                    Provider.of<SubjectProvider>(context, listen: false)
                        .addSubject(name, mark);
                    
                    _nameController.clear();
                    _markController.clear();
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Subject added successfully!')),
                    );
                  }
                },
                child: Text('Add Subject'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
