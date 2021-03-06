import 'package:badiup/colors.dart';
import 'package:badiup/models/stock_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum Category {
  apparel,
  foodAndBeverage,
  misc,
}

String getDisplayText(Category category) {
  switch (category) {
    case Category.apparel:
      return "服＆ファッション小物";
    case Category.foodAndBeverage:
      return "食品/飲料";
    case Category.misc:
      return "雑貨";
    default:
      return "";
  }
}

class Product {
  final String name;
  final String description;
  final double priceInYen;
  final List<String> imageUrls;
  final DateTime created;
  final String documentId;
  final bool isPublished;
  final Category category;
  final Stock stock;
  int displayOrder;

  Product({
    this.name,
    this.description,
    this.priceInYen,
    this.imageUrls,
    this.created,
    this.documentId,
    this.isPublished,
    this.category,
    this.stock,
    this.displayOrder,
  });

  String getPublishedStatusText() {
    if (isPublished) {
      return '公開済';
    } else {
      return '未公開';
    }
  }

  Widget getStatusDisplay() {
    return Container(
      height: 24,
      width: 52,
      decoration: BoxDecoration(
        color: isPublished ? paletteRoseColor : paletteGreyColor4,
      ),
      child: Center(
        child: Text(
          getPublishedStatusText(),
          style: TextStyle(
            color: isPublished ? paletteForegroundColor : paletteBlackColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  StockItem getRequestedStockItem(StockItem stockRequest) {
    StockItem productStockItem;

    if (stock.stockType == StockType.sizeAndColor) {
      productStockItem = stock.items.firstWhere(
        (stockItem) =>
            stockItem.size == stockRequest.size &&
            stockItem.color == stockRequest.color,
        orElse: () => null,
      );
    } else if (stock.stockType == StockType.sizeOnly) {
      productStockItem = stock.items.firstWhere(
        (stockItem) => stockItem.size == stockRequest.size,
        orElse: () => null,
      );
    } else if (stock.stockType == StockType.colorOnly) {
      productStockItem = stock.items.firstWhere(
        (stockItem) => stockItem.color == stockRequest.color,
        orElse: () => null,
      );
    } else {
      productStockItem = stock.items.first;
    }

    return productStockItem;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'priceInYen': priceInYen,
      'imageUrls': imageUrls,
      'created': created,
      'isPublished': isPublished,
      'category': category?.index,
      'stock': stock.toMap(),
      'displayOrder': displayOrder,
    };
  }

  Product.fromMap(Map<String, dynamic> map, String documentId)
      : assert(map['name'] != null),
        name = map['name'],
        description = map['description'],
        priceInYen = map['priceInYen'] + .0,
        imageUrls = map['imageUrls']?.cast<String>(),
        created = map['created'].toDate(),
        isPublished = map['isPublished'],
        category =
            map['category'] != null ? Category.values[map['category']] : null,
        stock = map['stock'] != null
            ? Stock.fromMap(map['stock'].cast<String, dynamic>())
            : null,
        displayOrder = map['displayOrder'] ?? 0,
        documentId = documentId;

  Product.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, snapshot.documentID);
}
