import 'package:artikel_islam/constants/api_endpoint.dart';
import 'package:artikel_islam/models/hadits.dart';

String LOCAL_ARTICLES = "artikel_muslim/articles";

String IMAGE_PLACEHOLDER = "https://i.stack.imgur.com/y9DpT.jpg";

class CategoryArticle {
  final String endpointUrl;
  final String logo;
  final String id;
  final String name;

  CategoryArticle({
    required this.name,
    required this.id,
    required this.endpointUrl,
    required this.logo,
  });
}

List<CategoryArticle> LIST_CATEGORIES = [
  CategoryArticle(
    logo: "https://i1.sndcdn.com/artworks-000249209479-6tn1y6-t500x500.jpg",
    endpointUrl: ApiEndpoint.KONSULTASI_SYARIAH,
    name: "Konsultasi Syariah",
    id: "ks",
  ),
  CategoryArticle(
    logo:
        "https://static.muslim.or.id/wp-content/uploads/2018/07/Master-Logo-Muslimorid_Muslimorid-Icon-Biru.jpg",
    endpointUrl: ApiEndpoint.MUSLIMORID,
    name: "Muslim.or.id",
    id: "ms",
  ),
  CategoryArticle(
    logo:
        "https://static.muslimah.or.id/wp-content/uploads/2018/05/Muslimahorid-icon.png",
    endpointUrl: ApiEndpoint.MUSLIMAHORID,
    name: "Muslimah.or.id",
    id: "msh",
  ),
];

List<Hadits> LIST_HADITS = [
  Hadits(
    text: "اتَّقِ اللَّهَ حَيْثُمَا كُنْتَ وَأَتْبِعِ السَّيِّىَٔةَ الْحَسَنَةَ تَمْحُهَا وَخَالِقِ النَّاسَ بِخُلُقٍ حَسَنٍ",
    translate: '“Bertakwalah kepada Allah dimanapun'
        ' engkau berada dan iringilah setiap'
        ' keburukan dengan kebaikan, niscaya ia akan'
        ' menghapuskan keburukan, dan pergauilah'
        ' manusia dengan akhlak yang baik”.',
    reference: "Hadits Hasan, Riwayat at-Tirmidzi, Abu"
        " Daud, Ahmad dan yang lainnya. Lihat"
        " Shahiihul jaami’ no. 97",
  ),
  Hadits(
    text: "الدُّٰعَاءُ هُوَ العِبَادَةُ",
    translate: '“Do’a adalah ibadah”.',
    reference: "Hadits Shahih, Riwayat Ashhabus Sunan."
        " Lihat Shahiihul jaami’ no. 3407",
  ),
  Hadits(
    text: "اتَّقُوا النّارَ وَلَوْ بِشِقِّ تَمْرَةٍ",
    translate: '“Jagalah diri kalian dari api neraka, meski'
        ' hanya dengan bersedekah sepotong kurma”.',
    reference: "Hadits Shahih, Riwayat Bukhari dan Muslim. Lihat Shahiihul jaami’ no. 114",
  ),
  Hadits(
    text: "اتّاقُوا الظُّلْمَ فَإِنَّ الظُّلْمَ ظُلُمَاتٌ يَوْمَ الْقِيَامَةِ",
    translate: '“Jagalah diri kalian dari perbuatan zalim, '
        ' karna sesungguhnya kezaliman itu akan'
        ' menjadi kegelapan pada hari kiamat”.',
    reference: "Hadits Shahih, Riwayat Ahmad. Lihat Shahiihul jaami’ no.101",
  ),
  Hadits(
    text: "اتَّقُوا اللَّهَ وَ صِلُوا أَر حَامَكُمْ",
    translate: '“Bertakwalah kalian kepada Allah, dan'
        ' sambunglah tali silaturrahim diantara kalian”.',
    reference: "Hadits Hasan, Riwayat Ibnu ‘Asakir. Lihat"
        " Shahiihul jaami’ no.108",
  ),
  Hadits(
    text: "الدِّيْنُ اانّصِيْحَةُ",
    translate: '“Agama adalah nasihat”.',
    reference: "Hadits Shahih, Riwayat Muslim. Lihat Shahiihul jaami’ no. 3417",
  ),
  Hadits(
    text: "لَيْسَ مِنَّا مَنْ لَمْ يَرْحَمْ صَغِيْرَنَا وَ يُوَقِّرْ كَبِيْرَنَاُ",
    translate: '“Bukanlah termasuk golongan kami, orang '
        ' yang tidak menyayangi anak kecil dan tidak'
        ' menghormati orang yang dituakan diantara kami”.',
    reference: "Hadits Shahih, Riwayat, At-Tirmidzi, Lihat"
        " Shahiihul jaami’ no.5445",
  ),
  Hadits(
    text: "مَنْ لَا يَرْحَمِ النَّاسَ لَا يَرْحَمْهُ اللَّهُ",
    translate: '“Barangsiapa yang tidak menyayangi '
        ' manusia, niscaya Allah tidak akan menyayanginya”.',
    reference: "Hadits Shahih, Riwayat Bukhori dan Muslim."
        " Lihat Shahiihul jaami’ no. 6597",
  ),
  Hadits(
    text: "الْمُؤْمِنُ مِرْآةُ الْمُؤْمِنُِ",
    translate: '“Seorang mu’min itu laksana cermin bagi mu’min yang lain”.',
    reference: "Hadits Shahih, Riwayat ath-Thabrani dalam kitab al-Ausath. Lihat Shahiihul jaami’ no. 6655",
  ),
  Hadits(
    text: "الْمَسْجِدُ بَيْتُ كُلِّ مُؤْمِنٍ",
    translate: '“Masjid adalah rumah bagi setiap mu’min”.',
    reference: "Hadits Hasan, Riwayat Abu Nu’aim dalam kitab al-Hilyah, Lihat Shahiihul jaami’ no. 6702",
  ),
];
