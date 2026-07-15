import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subject_provider.dart';

class SummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary'),
      ),
      body: Consumer<SubjectProvider>(
        builder: (context, subjectProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildSummaryItem(
                          'Total Subjects',
                          subjectProvider.totalSubjects.toString(),
                          Icons.book,
                        ),
                        Divider(),
                        _buildSummaryItem(
                          'Average Mark',
                          subjectProvider.averageMark.toStringAsFixed(1),
                          Icons.calculate,
                        ),
                        Divider(),
                        _buildSummaryItem(
                          'Overall Grade',
                          subjectProvider.overallGrade,
                          Icons.grade,
                          isGrade: true,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Passing Subjects: ${subjectProvider.passingSubjects.length}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                if (subjectProvider.subjects.isNotEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'All Subjects',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          ...subjectProvider.subjects.map((subject) {
                            return ListTile(
                              dense: true,
                              leading: Icon(Icons.fiber_manual_record,
                                  size: 12,
                                  color: _getGradeColor(subject.grade)),
                              title: Text(subject.name),
                              trailing: Text(
                                '${subject.mark.toStringAsFixed(1)} (${subject.grade})',
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon,
      {bool isGrade = false}) {
    return Row(
      children: [
        Icon(icon, size: 30),
        SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isGrade ? _getGradeColor(value) : null,
          ),
        ),
      ],
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A': return Colors.green;
      case 'B': return Colors.blue;
      case 'C': return Colors.orange;
      default: return Colors.red;
    }
  }
}
