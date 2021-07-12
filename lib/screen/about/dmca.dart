import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter/material.dart';

class Dmca extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: screensize.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: HtmlWidget('''<h1>DMCA policy</h1>
This Digital Millennium Copyright Act policy ("Policy") applies to the <a href="https://wrt.my.id/" target="_blank" rel="nofollow noopener">wrt.my.id</a> website ("Website" or "Service") and any of its related products and services (collectively, "Services") and outlines how this Website operator ("Operator", "we", "us" or "our") addresses copyright infringement notifications and how you ("you" or "your") may submit a copyright infringement complaint.

Protection of intellectual property is of utmost importance to us and we ask our users and their authorized agents to do the same. It is our policy to expeditiously respond to clear notifications of alleged copyright infringement that comply with the United States Digital Millennium Copyright Act ("DMCA") of 1998, the text of which can be found at the U.S. Copyright Office <a href="https://www.copyright.gov/" target="_blank" rel="noopener">website</a>.
<h2>What to consider before submitting a copyright complaint</h2>
Before submitting a copyright complaint to us, consider whether the use could be considered fair use. Fair use states that brief excerpts of copyrighted material may, under certain circumstances, be quoted verbatim for purposes such as criticism, news reporting, teaching, and research, without the need for permission from or payment to the copyright holder. If you have considered fair use, and you still wish to continue with a copyright complaint, you may want to first reach out to the user in question to see if you can resolve the matter directly with the user.

Please note that if you are unsure whether the material you are reporting is in fact infringing, you may wish to contact an attorney before filing a notification with us.

We may, at our discretion or as required by law, share a copy of your notification or counter-notification with third parties. This may include sharing the information with the account holder engaged in the allegedly infringing activity or for publication. If you are concerned about your information being forwarded, you may wish to <a href="https://www.copyrighted.com/professional-takedowns" target="_blank" rel="noopener">hire an agent</a> to report infringing material for you.
<h2>Notifications of infringement</h2>
If you are a copyright owner or an agent thereof, and you believe that any material available on our Services infringes your copyrights, then you may submit a written copyright infringement notification ("Notification") using the contact details below pursuant to the DMCA. All such Notifications must comply with the DMCA requirements. You may refer to a <a href="https://www.websitepolicies.com/create/dmca-takedown-notice" target="_blank" rel="noopener">DMCA takedown notice generator</a> or other similar services to avoid making mistake and ensure compliance of your Notification.

Filing a DMCA complaint is the start of a pre-defined legal process. Your complaint will be reviewed for accuracy, validity, and completeness. If your complaint has satisfied these requirements, our response may include the removal or restriction of access to allegedly infringing material as well as a permanent termination of repeat infringers’ accounts. A backup of the terminated account’s data may be requested, however, we may not be able to provide you with one and, as such, you are strongly encouraged to take your own backups.

If we remove or restrict access to materials or terminate an account in response to a Notification of alleged infringement, we will make a good faith effort to contact the affected user with information concerning the removal or restriction of access, which may include a full copy of your Notification (including your name, address, phone, and email address), along with instructions for filing a counter-notification.

Notwithstanding anything to the contrary contained in any portion of this Policy, the Operator reserves the right to take no action upon receipt of a DMCA copyright infringement notification if it fails to comply with all the requirements of the DMCA for such notifications.
<h2>Counter-notifications</h2>
A user who receives a copyright infringement Notification may make a counter-Notification pursuant to sections 512(g)(2) and (3) of the US Copyright Act. If you receive a copyright infringement Notification, it means that the material described in the Notification has been removed from our Services or access to the material has been restricted. Please take the time to read through the Notification, which includes information on the Notification we received. To file a counter-notification with us, you must provide a written communication compliant with the DMCA requirements.

Please note that if you are not sure whether certain material infringes the copyrights of others or that the material or activity was removed or restricted by mistake or misidentification, you may wish to contact an attorney before filing a counter-notification.

Notwithstanding anything to the contrary contained in any portion of this Policy, the Operator reserves the right to take no action upon receipt of a counter-notification. If we receive a counter-notification that complies with the terms of 17 U.S.C. § 512(g), we may forward it to the person who filed the original Notification.

The process described in this Policy does not limit our ability to pursue any other remedies we may have to address suspected infringement.
<h2>Changes and amendments</h2>
We reserve the right to modify this Policy or its terms relating to the Website and Services at any time, effective upon posting of an updated version of this Policy on the Website. When we do, we will post a notification on the main page of the Website.
<h2>Reporting copyright infringement</h2>
If you would like to notify us of the infringing material or activity, you may send an email to akunwrt@gmail.com.'''),
        ),
      ),
    );
  }
}
