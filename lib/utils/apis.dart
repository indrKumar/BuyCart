import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:vFASHU/utils/utils.dart';

import '../error/exceptions.dart';
import '../features/auth/data/models/loginotpmodal.dart';
import '../models/auth/usermodel.dart';
class ApiServisces {
  String baseUrl = "https://vfasu-backend-node.onrender.com/api/v1/";
  // Future<OTPSendResponse> loginOTP({
  //   required String number,
  // }) async {
  //   print("DATA SOURCE");
  //   try {
  //     var headers = {
  //       'Content-Type': 'application/json',
  //     };
  //     var request = http.Request('POST', Uri.parse('${baseUrl}auth/user/login'));
  //     request.body = json.encode({
  //       "contact": number,
  //     });
  //     request.headers.addAll(headers);
  //     log("NUMBER:::$number");
  //     http.StreamedResponse response = await request.send();
  //     if (kDebugMode) {
  //       print("RESPONSE:::${response.statusCode}");
  //     }
  //     if (response.statusCode == 200) {
  //       final responseBody = await response.stream.bytesToString();
  //       final responseJson = json.decode(responseBody);
  //       final userModel = OTPSendResponse.fromJson(responseJson);
  //       if (userModel.data.contact.isEmpty) {
  //         throw Exception('Contact information not found in the response');
  //       }
  //       return userModel;
  //     } else if (response.statusCode == 400) {
  //       final responseBody = await response.stream.bytesToString();
  //       final errorData = json.decode(responseBody);
  //       throw BadRequestException(errorData['message']);
  //     } else {
  //       throw ServerException('Error occurred during login: ${response.statusCode} - ${response.reasonPhrase}');
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }



Future<LoginOtpModal> verifyOTP({
    required String number,
  }) async {
    print("DATA SURCE");
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request('POST', Uri.parse('${baseUrl}login'));
      request.body = json.encode({
        "contact": number,
      });
      request.headers.addAll(headers);
      log("NUMBER:::$number");
      http.StreamedResponse response = await request.send();
      if (kDebugMode) {
        print("RESPONEE:::$response");
      }
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        return LoginOtpModal.fromJson(json.decode(responseBody));
      } else {
        throw const ServerException('Login failed');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

// product list
  Future<List<dynamic>> getProductList(String _currentPage,String _perPage) async {
    final response = await http.get(Uri.parse('${baseUrl}Productlist?page=$_currentPage&per_page=$_perPage'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }
  // item count badge
  Future<dynamic> itemCount() async {
    final response = await http.get(Uri.parse(baseUrl+'cartcount'),
      headers: {
        'Authorization': 'Bearer ${Constants.accessToken}',
        'Content-Type': 'application/json',
      },
    );
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
return data["data"];
    }
  }

  //cart list data
  Future<Map<String, dynamic>> cartList ()async{
    final response =await http.get(Uri.parse(baseUrl+"cartlist"), headers: {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',
    },);
  var  data = jsonDecode(response.body);
    if(response.statusCode==200){
      return data;
    } else {
  throw Exception('Failed to load cart data');
  }
  }


  //home page api
Future<Map<String,dynamic>> homePage()async{
    final response = await http.get(Uri.parse(baseUrl+"apphome"));
    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      return data;
    }else{
      throw Exception("Failed to load data");
    }
}

// product dtails
Future<Map<String,dynamic>>productDtail(String productId)async{
    final response =await http.get(Uri.parse(baseUrl+"productdetail/?product_id=$productId",));
    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      return data["data"];
    }else{
      throw Exception("id not found");
    }
}

// get coupons
Future<Map<String,dynamic>> getCopuns()async{
    final response = await http.get(Uri.parse("${baseUrl}Getcoupons"),
      headers: {
        'Authorization': 'Bearer ${Constants.accessToken}',
        'Content-Type': 'application/json',
      },
    );
    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      return data;
    }
    else{
      throw Exception("coupons not fund");
    }
}

  Future<dynamic> applyCoupon(String couponCode) async {
    var request = http.Request('PUT', Uri.parse('http://dev.teckhubsolutions.com/rest/V1/carts/mine/coupons/?coupon=$couponCode'));
    var headers = {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     return  response.stream.bytesToString();
    }
    else {
      print("els${response.reasonPhrase}");
    }
  }


  Future<dynamic> removeCopuns(String couponCode) async {
    var request = http.Request('DELETE', Uri.parse('http://dev.teckhubsolutions.com/rest/V1/carts/mine/coupons/?coupon=$couponCode'));
    var headers = {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return response.stream.bytesToString();
    }
    else {
      print(response.reasonPhrase);
    }
  }
  
  
  //add new Addresss
  Future<dynamic> addNewAddress(
      String firstName,lastName,
      // regionid, telephone,
      // street,
      ) async {
    var headers = {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',
    };
    var body = json.encode({
      "customer": {
        "email": "dwsmsss@gmail.com",
        "firstname":firstName,
        "lastname":lastName,
        "website_id": 1,
        "addresses": [
          {
            // "id": 2,
            "region": {
              "region_code": "UP",
              "region": "Uttar Pradesh",
              "region_id": 566
            },
            "country_id": "IN",
            "street": [
              "Wonder Valley"
            ],
            "telephone": "9911285904",
            "postcode": "201306",
            "city": "Noida",
            "firstname": "Girsdsdsddsseesh",
            "lastname": "Kumar",
            "default_shipping": true,
            "default_billing": true
          }
        ]
      }
    });
    final response = await http.put(
      Uri.parse("http://dev.teckhubsolutions.com/rest/V1/customers/me"),
      headers: headers,
      body: body,
    );

    print("body Parameter $body");
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      print(data);
      return data;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }


  Future<dynamic> addUpdate(String firstName,lastName,regionid, telephone,
      street,addressId) async {
    var headers = {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',
    };

    var body = json.encode({
      {
        "customer": {
          "email": "anurag@gmail.com",
          "firstname":firstName,
          "lastname":lastName,
          "website_id": 1,
          "addresses": [
            {
              "id": addressId,
              "region": {
                "region_code": "UP",
                "region": "Uttar Pradesh",
                "region_id": regionid
              },
              "country_id": "IN",
              "street": [
                "Wonder Valley"
              ],
              "telephone": telephone,
              "postcode": "201306",
              "city": "Noida",
              "firstname": firstName,
              "lastname": lastName,
              "default_shipping": true,
              "default_billing": true
            }
          ]
        }
      }
    });

    final response = await http.put(
      Uri.parse("http://dev.teckhubsolutions.com/rest/V1/customers/me"),
      headers: headers,
      body: body,
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      print(data);
      return data;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

//
  
  
  
  
  
//add to bag
  Future<dynamic> addToCart(String productId, int quantity, String productType) async {
    final response = await http.get(
      Uri.parse(baseUrl+"Addtocart?product_id=$productId&qty=$quantity&productType=$productType"),
      headers: {
        'Authorization': 'Bearer ${Constants.accessToken}',
        'Content-Type': 'application/json',
      },
    );
    final data =jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('Failed to add item to cart.');
    }
  }


  //SEARCH API

Future<dynamic> searchApi()async{
    final response = await http.get(Uri.parse("${baseUrl}Productsearch"));
    if(response.statusCode ==200){
      final data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception("product not fount");
    }
}
// update itemQuantity

  Future<dynamic> updateCartItem(String itemId, int qty, String productId) async {
    http.Response response = await http.get(Uri.parse(baseUrl+"Updatecartitems?item_id=$itemId&qty=$qty&product_id=$productId",),  headers: {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',
    },);
    Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      print('Failed to update cart item');
    }
  }

  // Categories List

  Future<dynamic> removeCartItem(String itemId,) async {
    http.Response response = await http.get(Uri.parse(baseUrl+"Removecartitem?item_id=$itemId",),  headers: {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',
    },);
    Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      print('Failed to update cart item');
    }
  }
// categories list
  Future<Map<String, dynamic>> categoriesList ()async{
    final response =await http.get(Uri.parse(baseUrl+"categorylist"), headers: {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',
    },);
    var  data = jsonDecode(response.body);
    if(response.statusCode==200){
      return data;
    } else {
      throw Exception('Failed to load cart data');
    }
  }

  // remove cart Item

 


// craete costumerr

  Future<Map<String, dynamic>> createCustomer(String number, String name, String gender, String mail) async {
    final response = await http.get(Uri.parse("${baseUrl}Createcustomer?mobile_no=$number&first_name=$name&gender=1&email=$mail"));

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        var data = jsonDecode(response.body);
        print(data);
        return data;
      } else {
        throw Exception('Empty response body');
      }
    } else {
      throw Exception('Failed to load cart data');
    }
  }

  // order detail
  Future<Map<String, dynamic>> orderDetails ()async{
    final response =await http.get(Uri.parse("${baseUrl}Orderlist"),
    headers: {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',
    }
    );
    var  data = jsonDecode(response.body);
    if(response.statusCode==200){
      print(data);
      return data;
    } else {
      throw Exception('Failed to load cart data');
    }
  }


  // addList
  Future<Map<String, dynamic>> addList ()async{
    final response =await http.get(Uri.parse("http://dev.teckhubsolutions.com/rest/V1/customers/me"), headers: {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',
    },);
    var  data = jsonDecode(response.body);
    if(response.statusCode==200){
    print("Address List$data");
      return data;
    } else {
      return data;
    }
  }

// tracker api
  Future<Map<String,dynamic>> trackerApi(String orderId) async {
    final response =
    await http.get(Uri.parse('http://dev.teckhubsolutions.com/mobapi/api/Trackorder?order_id=$orderId'),headers: {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
     return data;
    } else {
      throw Exception('Failed to fetch order details');
    }
  }
  Future<Map<String,dynamic>> costumerDetails(String orderId) async {
    final response =
    await http.get(Uri.parse("http://dev.teckhubsolutions.com/mobapi/api/customerdetails"),headers: {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch order details');
    }
  }



  //1
  Future<dynamic> estimateShippingMethods() async {
    var headers = {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',
    };
    var body = json.encode({
      "address": {
        "region": "Uttar Pradesh",
        "region_id": "566",
        "country_id": "IN",
        "street": [
          "Horse Bouldvard"
        ],
        "postcode": "201301",
        "city": "Noida",
        "firstname": "Gireesh",
        "lastname": "kumar",
        "email": "gireesh030@gmail.com",
        "telephone": "9911285904"
      }
    });
    final response = await http.post(
      Uri.parse("http://dev.teckhubsolutions.com/rest/V1/carts/mine/estimate-shipping-methods"),
      headers: headers,
      body: body,
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(data);
      return data;
      // Process the response data as needed
    } else {
      print('Request failed with status: ${response.statusCode}');
    }}

//2
  Future<dynamic> shippingInformation() async {
    var headers = {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',
    };
    var body = json.encode({
      "addressInformation": {
        "shipping_address": {
          "region": "Uttar Pradesh",
          "region_id": 566,
          "region_code": "UP",
          "country_id": "IN",
          "postcode": "201301",
          "street": ["Horse Bouldvard"],
          "city": "Noida",
          "telephone": "9911285904",
          "firstname": "Gireesh",
          "lastname": "Kumar",
          "email": "gireesh030@gmail.com"
        },
        "shipping_method_code": "freeshipping",
        "shipping_carrier_code": "freeshipping"
      }
    });
    final response = await http.post(
      Uri.parse("http://dev.teckhubsolutions.com/rest/V1/carts/mine/shipping-information"),
      headers: headers,
      body: body,
    );
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(data);
      return data;
      // Process the response data as needed
    } else {
      print('Request failed with status: ${response.statusCode}');
    }}


//3
  Future<dynamic> paymentInformation() async {
    var headers = {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',
    };
    var body = json.encode(
        {
          "paymentMethod": {
            "method": "cashondelivery"
          },
          "billing_address": {
            "email": "gireesh030@gmail.com.com",
            "region": "Uttar Pradesh",
            "region_id": "566",
            "region_code": "UP",
            "country_id": "IN",
            "street": ["Wonder Valley"],
            "postcode": "201306",
            "city": "Noida",
            "telephone": "99112285904",
            "firstname": "Gireesh",
            "lastname": "Kumar"
          },
          "shipping_address": {
            "email": "gireesh030@gmail.com",
            "region": "Uttar Pradesh",
            "region_id": "566",
            "region_code": "UP",
            "country_id": "IN",
            "street": ["Wonder Valley"],
            "city": "Noida",
            "postcode": "201306",
            "telephone": "9911285904",
            "firstname": "Gireesh",
            "lastname": "Kumar"
          },
          "shippingMethod": {
            "method": "freeshipping"
          }
        }
    );
    final response = await http.post(
      Uri.parse("http://dev.teckhubsolutions.com/rest/V1/carts/mine/payment-information"),
      headers: headers,
      body: body,
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(data);
      return data;
      // Process the response data as needed
    } else {
      print('Request failed with status: ${response.statusCode}');
    }}

  Future<dynamic> deleteAddress(String id) async {
    var headers = {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json'
    };

    try {
      final response = await http.delete(
        Uri.parse("http://dev.teckhubsolutions.com/mobapi/api/Customerdeleteaddress?address_id=id"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        print('Address deleted successfully');
      } else {
        print('Failed to delete address. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting address: $error');
    }
  }


  Future<Map<String,dynamic>>getRegion()async{
    final response =await http.get(Uri.parse("http://dev.teckhubsolutions.com/mobapi/api/Regions"));
    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      return data["data"];
    }else{
      throw Exception("Region not found");
    }
  }


  Future<Map<String,dynamic>>getSuggestionDataCArt()async{
    var headers = {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json'
    };

    final response = await http.get(Uri.parse("http://dev.teckhubsolutions.com/mobapi/api/Similarproducts"),
    headers: headers,
    );
    var data = jsonDecode(response.body);
    if(response.statusCode == 200){
      return data;
    }else{
      throw Exception("Region not found");
    }
  }
  Future<dynamic> ratting(String id, ratting) async {
    var headers = {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',
    };
    final response = await http.put(
      Uri.parse("http://dev.teckhubsolutions.com/mobapi/api/productrating?product_id=$id&rating=$ratting"),
      headers: headers,
    );

    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      print(data);
      return data;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }
  Future<dynamic> addFavorite(String id,) async {
    var headers = {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',
    };
    final response = await http.put(
      Uri.parse("http://dev.teckhubsolutions.com/mobapi/api/Productwishlist?product_id=$id&action=add"),
      headers: headers,
    );

    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      print(data);
      return data;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }
 Future<dynamic> deleteFavorite(String id,) async {
    var headers = {
      'Authorization': 'Bearer ${Constants.accessToken}',
      'Content-Type': 'application/json',
    };
    final response = await http.delete(
      Uri.parse("http://dev.teckhubsolutions.com/mobapi/api/Productwishlist?product_id=$id&action=remove"),
      headers: headers,
    );

    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      print(data);
      return data;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  Future<Map<String, dynamic>> getWishList() async {
    final response = await http.get(
      Uri.parse("http://dev.teckhubsolutions.com/mobapi/api/Productwishlist?action=list"),
      headers: {
        'Authorization': 'Bearer ${Constants.accessToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load cart data');
    }
  }

}


