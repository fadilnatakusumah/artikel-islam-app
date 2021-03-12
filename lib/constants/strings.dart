import 'package:artikel_islam/constants/api_endpoint.dart';

String LOCAL_ARTICLES = "artikel_muslim/articles";

String IMAGE_PLACEHOLDER = "https://i.stack.imgur.com/y9DpT.jpg";

class CategoryArticle {
  final String endpointUrl;
  final String logo;
  final String id;
  final String name;

  CategoryArticle({
    this.name,
    this.id,
    this.endpointUrl,
    this.logo,
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
    logo: "https://static.muslim.or.id/wp-content/uploads/2018/07/Master-Logo-Muslimorid_Muslimorid-Icon-Biru.jpg",
    endpointUrl: ApiEndpoint.MUSLIMORID,
    name: "Muslim.or.id",
    id: "ms",
  ),
  CategoryArticle(
    logo: "https://static.muslimah.or.id/wp-content/uploads/2018/05/Muslimahorid-icon.png",
    endpointUrl: ApiEndpoint.MUSLIMAHORID,
    name: "Muslimah.or.id",
    id: "msh",
  ),
];
