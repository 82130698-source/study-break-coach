import 'package:flutter/material.dart';

void main() => runApp(const StudyBreakApp());

class StudyBreakApp extends StatelessWidget {
  const StudyBreakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Break Coach',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const BreakPage(),
    );
  }
}

class BreakPage extends StatefulWidget {
  const BreakPage({super.key});

  @override
  State<BreakPage> createState() => _BreakPageState();
}

class _BreakPageState extends State<BreakPage> {
  int minutes = 5;
  String focus = 'Low';
  String suggestion = 'Choose your time and focus level, then tap the button.';

  void suggestBreak() {
    setState(() {
      if (focus == 'Low') {
        suggestion = 'Rest your eyes and take a few slow breaths for $minutes minutes.';
      } else if (minutes >= 10) {
        suggestion = 'Take a short walk and stretch for $minutes minutes.';
      } else {
        suggestion = 'Stand up, stretch your shoulders, and drink some water.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Study Break Coach')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Plan a quick study break',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            DropdownButtonFormField<int>(
              value: minutes,
              decoration: const InputDecoration(labelText: 'Time available'),
              items: [5, 10, 15]
                  .map((n) => DropdownMenuItem(value: n, child: Text('$n minutes')))
                  .toList(),
              onChanged: (value) => setState(() => minutes = value ?? 5),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: focus,
              decoration: const InputDecoration(labelText: 'How focused do you feel?'),
              items: ['Low', 'Medium', 'High']
                  .map((level) => DropdownMenuItem(value: level, child: Text(level)))
                  .toList(),
              onChanged: (value) => setState(() => focus = value ?? 'Low'),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: suggestBreak,
              child: const Text('Suggest a Break'),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(suggestion, style: const TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
