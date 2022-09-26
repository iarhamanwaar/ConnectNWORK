import 'package:connectnwork/models/iaddress_schema.dart';
import 'package:connectnwork/services/api_service.dart';

class LocationRepository {
  static Future<List<IAddressSchema>> getAddress(String address) async {
    try {
      final response = await APIService.get(
        endpoint: '/api/location/predict?text=$address',
      );

      return iAddressSchemaFromJson(response.body);
    } catch (e) {
      throw 'Exception thrown from LocationRepository while getting address.';
    }
  }
}
