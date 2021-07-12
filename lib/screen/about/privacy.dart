import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: screensize.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: HtmlWidget('''<!-- wp:heading -->
<h2>Siapa kami</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Alamat situs web kami adalah: https://wrt.my.id.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>Data pribadi apa yang kami kumpulkan dan mengapa kami mengumpulkannya</h2>
<!-- /wp:heading -->

<!-- wp:heading {"level":3} -->
<h3>Komentar</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Saat pengunjung meninggalkan komentar pada situs, kita mengumpulkan data yang ditampilkan pada form komentar, alamat IP pengunjung dan user agent browser untuk membantu pendeteksian spam.</p>
<p>String anonim yang dibuat dari alamat email Anda (juga disebut hash) dapat diberikan ke layanan Gravatar untuk melihat apakah Anda menggunakannya. Kebijakan privasi layanan Gravatar tersedia di sini: https://automattic.com/privacy/. Setelah persetujuan atas komentar Anda, gambar profil Anda dapat dilihat oleh publik dalam konteks komentar Anda.</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3>Media</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Jika Anda mengunggah gambar ke situs web, Anda harus menghindari mengunggah gambar dengan data lokasi tertanam (GPS EXIF) yang disertakan. Pengunjung ke situs web dapat mengunduh dan mengekstrak data lokasi apa pun dari gambar di situs web.</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3>Formulir Kontak</h3>
<!-- /wp:heading -->

<!-- wp:heading {"level":3} -->
<h3>Cookies</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Jika Anda meninggalkan komentar di situs kami, Anda dapat memilih untuk menyimpan nama, alamat email, dan situs web Anda dalam cookie. Ini untuk kenyamanan Anda sehingga Anda tidak perlu mengisi detail Anda lagi ketika Anda meninggalkan komentar lain. Cookie ini akan bertahan selama satu tahun.</p>
<p>Jika Anda mengunjungi laman login kami, kami akan memasang cookie sementara untuk memastikan apakah browser Anda menerima cookie. Cookie ini tidak mengandung data pribadi dan dibuang ketika Anda menutup browser Anda.</p>
<p>Saat Anda log masuk, kami akan menyiapkan beberapa cookie untuk menyimpan informasi log masuk Anda dan tampilan yang Anda pilih. Cookie log masuk berlaku selama dua hari, dan cookie pengaturan tampilan berlaku selama satu tahun. Jika Anda memilih "Ingatkan Saya", log masuk anda akan bertahan selama dua minggu. Jika Anda log keluar dari akun, cookie log masuk akan dihapus.</p>
<p>Jika Anda menyunting atau menerbitkan artikel, cookie tambahan akan disimpan di browser Anda. Cookie ini tidak menyertakan data pribadi dan hanya menunjukkan ID posting dari artikel yang baru saja Anda sunting. Kadaluwarsa setelah 1 hari.</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3>Konten yang disematkan dari situs web lain</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Artikel-artikel di dalam situs ini dapat menyertakan konten terembed (seperti video, gambar, artikel, dll). Konten terembed dari situs web lain akan berlaku sama dengan pengunjung yang mengunjungi situs web lain.</p>
<p>Situs-situs web ini dapat mengumpulkan data tentang Anda, menggunakan cookies, menanamkan pelacak dari pihak ketiga, dan memonitor interaksi Anda dengan muatan tertanam, termasuk menggunakannya untuk melacak interaksi Anda jika Anda memiliki sebuah akun dan masuk ke dalam situs web tersebut.</p>
<!-- /wp:paragraph -->

<!-- wp:heading {"level":3} -->
<h3>Analitik</h3>
<!-- /wp:heading -->

<!-- wp:heading -->
<h2>Dengan siapa kami membagi data Anda</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Jika Anda meminta pengaturan ulang kata sandi, alamat IP Anda akan dimasukkan dalam email pengaturan ulang.</p>
<p>Kami mungkin juga membagikan data IP, Email, Jenis Perangkat, dan Lokasi kepada Layanan pihak ketiga untuk keperluan Statistik.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>Berapa lama kami menyimpan data Anda</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Jika Anda meninggalkan komentar, komentar dan metadatanya dipertahankan tanpa batas. Ini agar kami dapat mengenali dan menyetujui komentar tindak lanjut secara otomatis dan tidak menahannya dalam antrean moderasi.</p>
<p>Untuk pengguna yang mendaftar pada website kami (jika ada), kami juga menyimpan informasi pribadi yang mereka berikan dalam profil pengguna mereka. Semua pengguna dapat melihat, mengedit, atau menghapus informasi pribadi mereka kapan saja (kecuali mereka tidak dapat mengubah nama pengguna mereka). Administrator situs juga dapat melihat dan mengedit informasi tersebut.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>Hak apa yang Anda miliki atas data Anda</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Jika anda mempunyai akun di situs ini, atau telah meninggalkan komentar, anda dapat meminta untuk mendapat data personal dalam file export dari kami, termasuk data yang anda berikan kepada kami. Anda juga dapat meminta kami menghapus data personal mengenai anda. Ini tidak termasuk data yang wajib kami simpan untuk keperluan administratif, hukum, atau keamanan.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>Ke mana kami kirim data Anda</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Komentar pengunjung dapat diperiksa melalui layanan deteksi spam otomatis.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>Informasi kontak Anda</h2>
<!-- /wp:heading -->

<!-- wp:heading -->
<h2>Informasi tambahan</h2>
<!-- /wp:heading -->

<!-- wp:heading {"level":3} -->
<h3>Bagaimana kami melindungi data Anda</h3>
<!-- /wp:heading -->

<!-- wp:heading {"level":3} -->
<h3>Apa prosedur kebocoran data yang kami miliki</h3>
<!-- /wp:heading -->

<!-- wp:heading {"level":3} -->
<h3>Pihak ketiga mana saja data yang kami terima berasal</h3>
<!-- /wp:heading -->

<!-- wp:heading {"level":3} -->
<h3>Apa pengambilan keputusan otomatis dan/atau profil yang kami lakukan dengan data pengguna</h3>
<!-- /wp:heading -->

<!-- wp:heading {"level":3} -->
<h3>Persyaratan pengungkapan regulasi industri</h3>
<!-- /wp:heading -->'''),
        ),
      ),
    );
  }
}
