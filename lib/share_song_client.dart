import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'conversion_response.dart';

class ShareSongClient {
  static final String _baseUrl = 'https://convert-f47vs76u2q-ew.a.run.app/';

  Future<ConversionResponse> convert(String originServiceUrl, String targetService) async {
    final response = await http.get(Uri.parse('$_baseUrl?originServiceUrl=$originServiceUrl&targetService=$targetService'));

    if (response.statusCode == 200) {
      return ConversionResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error converting song');
    }
  }
}

part 'conversion_response.g.dart';

@JsonSerializable()
class ConversionResponse {
  final String targetServiceUrl;
  final String originService;

  ConversionResponse({
    required this.targetServiceUrl,
    required this.originService,
  });

  factory ConversionResponse.fromJson(Map<String, dynamic> json) => _$ConversionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ConversionResponseToJson(this);
}
