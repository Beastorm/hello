import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../models/language_model.dart';

Future<List<LanguageData>> getLanguages() async {
  final String url =
      '${GlobalConfiguration().getValue('base_url')}languageList';
  var client = http.Client();

  var response = await client.post(url);
  print(response.statusCode);
  if (response.statusCode == 200) {
    return languageModelFromJson(response.body).data;
  } else
    return null;
}
