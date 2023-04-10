import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7165D6),
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            Text(
              'We are committed to protecting your privacy. This privacy policy sets out how we use and protect any information that you give us when you use this application. We are committed to ensuring that your privacy is protected. Should we ask you to provide certain information by which you can be identified when using this application, then you can be assured that it will only be used in accordance with this privacy statement.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 16),
            Text(
              'Information We Collect',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Text(
              'We may collect information about you when you use our application. This information may include:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('- Name and contact information including email address'),
                  Text('- Medical information including medical history, prescriptions, and test results'),
                  Text('- Your device information, such as device type and operating system'),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'How We Use Your Information',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Text(
              'We may use the information we collect from you to:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('- To provide healthcare services to you and manage your medical records'),
                  Text('- Improve and optimize our application'),
                  Text('- Send you promotional communications, if you have opted in to receive them'),
                  Text('- Respond to your support requests and inquiries'),
                ],
              ),
            ),
            
            SizedBox(height: 16),
            Text(
              'Security',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Text(
              'We take reasonable measures to protect your information from unauthorized access, use, and disclosure. However, no method of transmission over the internet, or method of electronic storage, is 100% secure.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}