import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: screensize.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: HtmlWidget('''<h1>Contact Us : </h1>

<h2>Email : <a href="mailto:worldromancetranslation@gmail.com">worldromancetranslation@gmail.com</a> </h2>

<h2>Discord : <a href="https://discord.com/invite/ktfqKn6">https://discord.com/invite/ktfqKn6</a> </h2>


<h2>About Website : <a href="mailto:akunwrt@gmail.com">akunwrt@gmail.com</a> </h2>
'''),
        ),
      ),
    );
  }
}
