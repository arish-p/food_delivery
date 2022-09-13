import 'package:food_dilivery/models/category.dart';
import 'package:food_dilivery/models/productDetail.dart';
import 'package:gsheets/gsheets.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class FoodDiliverySheetsApi {


  static const String url = "https://script.google.com/macros/s/AKfycbz5e3gqrQR7g9krvrxdX8BSBGED7ycXL7gVc3oApRc2-LeMSy4/exec";

  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "fooddilivery",
  "private_key_id": "c197d855b8db112e744b0bf3579725f83aa19b77",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDu5XNc+JisWkzq\nlVcR1Z6ZZu6OxlEdpD/ySLdFeY0hOxQNoKadwxDySLoRAQM/En3Qxn2ajdZOQrMr\n9uF5Q8fXiKiNRGrCAHxIBGxAQ0UhMzon8I5p0fArH+it4D+njF1dnKsxvsMSrCHd\nPWQ1nDg7juhhSn+3zjg9Pu5HAUKNt59t1n23jxlVpG+alw+g673SyxxnveZWDia+\nPEB7cllx+lDak02gGbF6WqVHtR3zuSzDVVjeZVG0U03YEgapCY/LgPQxJ5z3Ogw7\nHGStDH2zLJcFs+Q6wdHdewJOdHcRzmjrJQpw5GblY1h9+0mfZUIFpadY5nIo23+h\nvhu46z1pAgMBAAECggEAERWx8bJ9QXvQJ8lxwyUN8emSSP3c1WvzZZfjgRTBNGDk\nI79bLknB7GapskdqXIUT7Pp51BpHR8YhLmIHD2P62d3izZhYspjtsNbQ73czU/Cb\nPNNi0/JY8Zr9sHJ3pIgqZMrGB+MDhdI8NihkTymZCevD9n7cWG0ale+D6epCQLeZ\nAIKS7xVI+AD5NLorcVr521mEjI5Uqc79K+j8FsmIwr7bzvmVGJnktpbhI92BZiMq\n97L0Nzprne90T++ZBtp5N2DBMHdnaode44zUNcU8+yfeVNFguqRyGFpolfe5QBuQ\nBM+UUtzY39oo17Mre7viQML8MHkskp9PT5sXCiBwwwKBgQD9wFvxISuLc7/CLnzD\nlDToqXuAYTywvsM83AcYS54PHiZJQYR2fY4+3sei9ONmbjXFQc3rJNRr+L35Qe1T\njGJI6Z5UBkKfShJWjzBl3/U0eA53yaUe2gVhfbxL7Y18ufPa+jw6R8XdpUJpdxg9\nfd16+7mpEpBnHehR+Hrujq82gwKBgQDxA2Rvu9+v34w5iMeb5zjGFEzHu+ktlkNO\nW5ZamPNEs+Hqq0vTVvhJ8DhC4d4KisZpiicDEv5vnP32xtCis4D6kGSwed1r52Rb\n7eLHD6YOKMz+whLZPJnE9u2pc4FjeYP5bgoK0KnLSVjBhmGIV8UpGJzVruXVhqZG\nzrn3up/YowKBgQDlcZjxKNgR6WC7+YLw6cMJma5FgCb7fhJVpnJ34nASJWXjGW3o\nIlGLwa9sRtiT1xWhvoWumIfG9Yz5pEYvJKH+Yde7DEoTdEuunxzZES/L+L7ES72V\nbvgslh+73BnybMX1/AyXeiyM5RBvArQVbgjlWlYfbdzKkL1v2Sl3Ked+dwKBgQDw\n82NGEZ3gRq36FzT4OIIaBdF9HfBRExjXDdmTWbZbyTrjUb3M2/X+dZrJwuYpw/P5\nL5UxDZwyGdINFVcgUjVwS0te43bqmbtL7Nf8CzkIjuHjEEOny14v/G4+KqwAt0up\n4slHZrVZ90o0sBRyKs2B+IlTWDeO8b7qq2JguMN14QKBgQCwfkh6r3sE49xUJiu/\nfOal4QInDbFsbnRbtZpJxZeIcDKMiSxfNy3qcO5VFBP4O0ZlxsbmSdWEjzkhqVxN\nMPlbNMHXGfsGb/zJu/hT1lFkShGNOlToYu2l03Z9vXCOCPVb2cr1IZ8lkuNbh+1f\nz9A1fn1v73bdN117S7h1K0G58g==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@fooddilivery.iam.gserviceaccount.com",
  "client_id": "115689193966676515636",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40fooddilivery.iam.gserviceaccount.com"
} 
  ''';
  static const _spreadsheetId = '1IejbraR0RCakwhq_uTsb7OtpghBFWqtMzwbFJ1iWxp4';

  static final _gheets = GSheets(_credentials);

  static Worksheet? _categorySheet;
  static Worksheet? _productsSheet;
  static Worksheet? _productDetailSheet;

  static Future init() async {
    final spreadsheet = await _gheets.spreadsheet(_spreadsheetId);
    _categorySheet = await _getWorkSheet(spreadsheet, title: 'Categories');
    _productsSheet = await _getWorkSheet(spreadsheet, title: 'Products');
    _productDetailSheet = await _getWorkSheet(spreadsheet, title: 'ProductDetail');
  }
  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet, {
        required String title,
      }) async {
    try{
      return await spreadsheet.addWorksheet(title);
    }catch(e){
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<Category?> getById(int id) async {
    if(_categorySheet == null) return null;

    final json = await _categorySheet!.values.map.rowByKey(id, fromColumn: 1);

    return json == null ? null : Category.fromJson(json);
  }

  static Future<List<Category>> getAllCategory() async{
    if(_categorySheet == null) return <Category>[];

    final categories = await _categorySheet!.values.map.allRows();

    return categories == null ? <Category>[] : categories.map(Category.fromJson).toList();

  }

  static Future<List<Product>> getAllProducts() async {
    if(_productsSheet == null) return <Product>[];

    final products = await _productsSheet!.values.map.allRows();

    return products == null ? <Product>[] : products.map(Product.fromJson).toList();
  }

  static Future<List<ProductDetail>> getAllDetail() async {
    if(_productDetailSheet == null) return <ProductDetail>[];

    final detailProducts = await _productDetailSheet!.values.map.allRows();

    return detailProducts == null ? <ProductDetail>[] : detailProducts.map(ProductDetail.fromJson).toList();
  }





  /*static void submitForm () async{
    var url = Uri.parse(FoodDiliverySheetsApi.url);
    var response = await http.post(url, body: {["Categories"], ["get_category"]});
    print(response);
  }*/

}