import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: screensize.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: HtmlWidget('''
          <p>Aplikasi ini dibuat karena gabut aja libur gk ada kerjaan</p>
          <p>Thanks to me, Owner WRT, semua staff WRT, semua reader WRT, dan semua Manusia</p>
<h2>Version Log</h2>
<h4>Versi 1.0.0 (Beta)</h4>
<ul>
  <li>Rilis Perdana</li>
  <li>Basic Fitur (Baca, Komentar, React, Search, Manga List)</li>
  <li>Login Akun (Belum Berguna akunnya, rencana untuk nyimpen pengaturan,bookmark,dan history)</li>
  <li>Notifikasi Update (Always On, belum bisa dimatikan)</li>
  <li>Load gambar Chapter secara bersamaan</li>
  <li>Chatango</li>
</ul>

'''),
        ),
      ),
    );
  }
}
