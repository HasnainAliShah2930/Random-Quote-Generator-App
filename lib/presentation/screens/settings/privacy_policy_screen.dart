import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Effective Date: July 1, 2026',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            const SizedBox(height: 20),
            _buildParagraph(
              context,
              'Hasnain Ali Shah built the Random Quote Generator app as a Free app. This SERVICE is provided by Hasnain Ali Shah at no cost and is intended for use as is.',
            ),
            _buildParagraph(
              context,
              'This page is used to inform visitors regarding the policies regarding the collection, use, and disclosure of Personal Information if anyone decided to use this Service.',
            ),
            _buildParagraph(
              context,
              'If you choose to use this Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that is collected is used for providing and improving the Service. Your information will not be used or shared with anyone except as described in this Privacy Policy.',
            ),
            _buildSectionTitle(context, 'Information Collection and Use'),
            _buildParagraph(
              context,
              'For a better experience while using our Service, you may be required to provide us with certain personally identifiable information. The information that is requested will be retained on your device and is not collected by the developer in any way.',
            ),
            _buildParagraph(
              context,
              'The app uses third-party services that may collect information used to identify you.',
            ),
            _buildSectionTitle(context, 'Local Storage and Device Access'),
            _buildParagraph(
              context,
              'To provide the features of Random Quote Generator, the app utilizes your device\'s local storage and specific features:',
            ),
            _buildBulletPoint(
              context,
              'Favorites & Settings: Your saved favorite quotes, category preferences, and application settings (such as Light/Dark mode, Font Size, and Sound preferences) are saved locally on your device. We do not transmit or store this data on external servers.',
            ),
            _buildBulletPoint(
              context,
              'Notifications: The app requests permission to send you local push notifications for the "Quote Notifications" feature (daily inspiration).',
            ),
            _buildBulletPoint(
              context,
              'Clipboard Access: The app requires access to your device\'s clipboard solely for the "Auto Copy Quote" and manual copy features, allowing you to paste quotes into other applications. This data is not tracked or transmitted by us.',
            ),
            _buildSectionTitle(context, 'Log Data'),
            _buildParagraph(
              context,
              'Whenever you use this Service, in a case of an error in the app, data and information (through third-party products) may be collected on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing the Service, the time and date of your use of the Service, and other statistics.',
            ),
            _buildSectionTitle(context, 'Security'),
            _buildParagraph(
              context,
              'We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and absolute security cannot be guaranteed.',
            ),
            _buildSectionTitle(context, 'Links to Other Sites'),
            _buildParagraph(
              context,
              'This Service may contain links to other sites (such as when you share a quote to a social media platform). If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, it is strongly advised that you review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.',
            ),
            _buildSectionTitle(context, 'Children’s Privacy'),
            _buildParagraph(
              context,
              'These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13 years of age. In the case we discover that a child under 13 has provided personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that necessary actions can be taken.',
            ),
            _buildSectionTitle(context, 'Changes to This Privacy Policy'),
            _buildParagraph(
              context,
              'This Privacy Policy may be updated from time to time. Thus, you are advised to review this page periodically for any changes. You will be notified of any changes by the posting of the new Privacy Policy on this page.',
            ),
            _buildSectionTitle(context, 'Contact Us'),
            _buildParagraph(
              context,
              'If you have any questions or suggestions about this Privacy Policy, do not hesitate to contact us at:',
            ),
            const Text(
              'hasnainalishahg2930@gmail.com',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
    );
  }

  Widget _buildParagraph(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          height: 1.5,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    final color = Theme.of(context).textTheme.bodyMedium?.color;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 15, height: 1.5, color: color),
            ),
          ),
        ],
      ),
    );
  }
}
