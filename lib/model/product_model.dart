// // To parse this JSON data, do
// //
// //     final productModel = productModelFromJson(jsonString);

// import 'dart:convert';

// ProductModel productModelFromJson(String str) =>
//     ProductModel.fromJson(json.decode(str));

// String productModelToJson(ProductModel data) => json.encode(data.toJson());

// class ProductModel {
//   int id;
//   String code;
//   String productName;
//   int stock;

//   ProductModel({
//     required this.id,
//     required this.code,
//     required this.productName,
//     required this.stock,
//   });

//   factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
//         id: json["id"],
//         code: json["code"],
//         productName: json["productName"],
//         stock: json["stock"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "code": code,
//         "productName": productName,
//         "stock": stock,
//       };
// }
