import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactScreen extends StatefulWidget {
  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String name = '';
  String message = '';
  bool sending = false;
  // Replace with your Formspree endpoint
  final String formspreeEndpoint = 'https://formspree.io/f/yourFormId';

  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => sending = true);
    try {
      final r = await http.post(Uri.parse(formspreeEndpoint), body: {
        'name': name,
        'email': email,
        'message': message,
      }, headers: {
        'Accept': 'application/json'
      });

      if (r.statusCode == 200 || r.statusCode == 201) {
        _showSnack('Message sent — thank you!');
        _formKey.currentState!.reset();
      } else {
        _showSnack('Failed to send. Status: ${r.statusCode}');
      }
    } catch (e) {
      _showSnack('Error sending message: $e');
    } finally {
      setState(() => sending = false);
    }
  }

  void _showSnack(String s) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.pinkAccent, Colors.purpleAccent],
          ).createShader(bounds),
          child: Text(
            'Contact',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.pinkAccent.withOpacity(0.1),
                        Colors.purpleAccent.withOpacity(0.1),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 48,
                        color: Colors.pinkAccent,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Get in Touch',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'I\'d love to hear from you!',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person_outline, color: Colors.purpleAccent),
                ),
                onSaved: (v) => name = v ?? '',
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined, color: Colors.purpleAccent),
                ),
                onSaved: (v) => email = v ?? '',
                validator: (v) => (v != null && v.contains('@')) ? null : 'Enter valid email',
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Message',
                  prefixIcon: Icon(Icons.message_outlined, color: Colors.purpleAccent),
                ),
                onSaved: (v) => message = v ?? '',
                maxLines: 6,
                validator: (v) => (v != null && v.trim().length >= 5) ? null : 'Message too short',
              ),
              const SizedBox(height: 24),
              sending
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: _send,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Send Message',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
