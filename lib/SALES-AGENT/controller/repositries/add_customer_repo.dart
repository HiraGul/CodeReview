import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tojjar_delivery_app/SALES-AGENT/data/models/add_customer_error_model.dart';
import 'package:tojjar_delivery_app/SALES-AGENT/utils/global_field_and_variable.dart';

import '../../../DELIVERY/Data/Models/login_model.dart';
import '../../../DELIVERY/Utils/api_status_code.dart';
import '../../../DELIVERY/Utils/app_sharedPrefs.dart';
import '../../../DELIVERY/Utils/baseurl.dart';
import '../../data/dataController/data_controller.dart';
import '../../data/models/add_customer_model.dart';

class AddCustomerRepo {
  Future<int> addCustomer() async {
    LoginModel? loginModel = MySharedPrefs.getUser();
    var encodeShopCategory = json.encode(shopCategory);
    try {
      var headers = {
        'Accept': 'application/json',
        'X-Authorization': 'Bearer ${loginModel!.accessToken}',
        'Authorization': 'Bearer ${loginModel.accessToken}'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('${BaseUrl.baseUrl}sale-agent/customers/store'));
      request.fields.addAll({
        'name': nameController.text.trim(),
        'email':
            emailController.text.isEmpty ? '' : emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'secondary_phone': secondPhoneController.text.isEmpty
            ? ''
            : secondPhoneController.text.trim(),
        'password': passwordController.text.trim(),
        'id_number': idController.text.trim(),
        'vat_number':
            vatController.text.isEmpty ? '' : vatController.text.trim(),
        'license_number': licenseController.text.trim(),
        'shop_name': shopNameController.text.trim(),
        'shop_address': shopAddressController.text.trim(),
        'district_name': districtId.toString(),
        'country_id': countryId.toString(),
        'city_id': cityId.toString(),
        'state_id': stateId.toString(),
        "longitude": myLongitude.toString(),
        "latitude": myLatitude.toString(),
        'location_link': locationLink!,
        'shop_type': shopType!,
        'shop_category[]': encodeShopCategory
      });
      if (crImage != null) {
        request.files
            .add(await http.MultipartFile.fromPath('cr_image', crImage!));
      }
      if (certificateImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'vat_certificate_image', certificateImage!));
      }
      if (shopImage != null) {
        request.files
            .add(await http.MultipartFile.fromPath('shop_image', shopImage!));
      }
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        addCustomerModelController =
            addCustomerModelFromJson(await response.stream.bytesToString());
        clearFields();
      }
      if (response.statusCode == 422) {
        addCustomerErrorModelController = addCustomerErrorModelFromJson(
            await response.stream.bytesToString());
      }
      if (response.statusCode == 413) {
        addCustomerErrorModelController = addCustomerErrorModelFromJson(
            await response.stream.bytesToString());
      }
      return response.statusCode;
    } on SocketException {
      return ApiStatusCode.socketException;
    } catch (e) {
      return ApiStatusCode.badRequest;
    }
  }

  clearFields() {
    nameController.clear();
    phoneController.clear();
    secondPhoneController.clear();
    vatController.clear();
    licenseController.clear();
    shopAddressController.clear();
    shopNameController.clear();
    districtId = null;
    countryId = null;
    cityId = null;
    stateId = null;
    myLatitude = null;
    myLongitude = null;
    locationLink = null;
    shopType = null;
    shopCategory.clear();
    passwordController.clear();
    idController.clear();
  }
}
