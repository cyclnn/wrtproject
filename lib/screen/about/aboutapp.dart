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
<h4>Versi 1.0.1 (Beta)</h4>
<ul>
  <li>Fix warna teks tertimpa background</li>
  <li>Fix beberapa sinopsis tidak muncul</li>
</ul>
<h4>Versi 2.0.0 (Beta)</h4>
<ul>
  <li>Tambahan fitur bookmark (beta)</li>
  <li>Klik back 2 kali untuk close aplikasi</li>
  <li>Ubah warna tema</li>
  <li>Ubah beberapa tata letak UI</li>
  <li>Peningkatan performa aplikasi menjadi lebih smooth</li>
  <li>On/Off notifikasi</li>
  <li>Live recent read tanpa perlu back ke home dahulu</li>
  <li>Perbaikan fungsi search</li>
  <li>Perbaikan page Komentar (Sebelumnya tidak bisa login disqus)</li>
</ul>

'''),
        ),
      ),
    );
  }
}
