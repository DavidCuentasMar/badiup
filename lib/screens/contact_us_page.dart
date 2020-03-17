import 'package:badiup/colors.dart';
import 'package:badiup/constants.dart' as constants;
import 'package:badiup/sign_in.dart';
import 'package:badiup/widgets/banner_button.dart';
import 'package:badiup/widgets/cart_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  final TextStyle _tableTextStyle = TextStyle(
    color: paletteBlackColor,
    fontWeight: FontWeight.w300,
    fontSize: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      bottomNavigationBar: BannerButton(
        onTap: () {
          Navigator.pop(context);
        },
        text: "商品リストへ",
      ),
    );
  }

  Widget _buildAppBar(context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: paletteLightGreyColor,
      iconTheme: IconThemeData(color: paletteBlackColor),
      actions: <Widget>[
        currentSignedInUser.isAdmin() ? Container() : CartButton(),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 24.0, vertical: 12.0),
      child: ListView(
        children: <Widget>[
          _buildStoreInfoTitle(),
          SizedBox( height: 20.0 ),
          _buildStoreInfoTable(),
          SizedBox( height: 20.0 ),
          _buildPrivacyPolicyLink()
        ],
      ),
    );
  }

  Widget _buildStoreInfoTitle() {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: kPaletteBorderColor),
        ),
      ),
      child: Text(
        '店舗情報',
        style: TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.bold, color: paletteBlackColor,
        ),
      ),
    );
  }

  Widget _buildStoreInfoTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kPaletteBorderColor)
      ),
      child: Column(
        children: <Widget>[
          _buildStoreNameRow(),
          _buildStoreAddressRow(),
          _buildStoreContactRow(),
        ],
      ),
    );
  }

  Widget _buildStoreNameRow() {
    return Container(
      height: 55.0,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: kPaletteBorderColor),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 100.0,
            padding: EdgeInsets.only( left: 10.0 ),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Color(0xFFE3E3E3),
              border: Border(
                right: BorderSide(color: kPaletteBorderColor),
              ),
            ),
            child: Text('ショップ名', style: _tableTextStyle),
          ),
          Container(
            padding: EdgeInsets.only( left: 10.0 ),
            alignment: Alignment.centerLeft,
            child: Text('バディカフェ', style: _tableTextStyle),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreAddressRow() {
    return Container(
      height: 95.0,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: kPaletteBorderColor),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 100.0,
            padding: EdgeInsets.only( left: 10.0 ),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Color(0xFFE3E3E3),
              border: Border(
                right: BorderSide(color: kPaletteBorderColor),
              ),
            ),
            child: Text('住所', style: _tableTextStyle),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only( left: 10.0, top: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('〒444-2149', style: _tableTextStyle),
                  Text('愛知県岡崎市細川町字窪地77-207', style: _tableTextStyle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreContactRow() {
    return Container(
      height: 120.0,
      child: Row(
        children: <Widget>[
          Container(
            width: 100.0,
            padding: EdgeInsets.only( left: 10.0 ),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Color(0xFFE3E3E3),
              border: Border(
                right: BorderSide(color: kPaletteBorderColor),
              ),
            ),
            child: Text('連絡先', style: _tableTextStyle),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only( left: 10.0, top: 15.0, bottom: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.phone, color: paletteDarkRedColor, size: 20.0,),
                      Text('0564-73-0889', 
                        style: TextStyle( color: paletteDarkRedColor),
                      ),
                    ],
                  ),
                  Text('【受付時間】', style: _tableTextStyle),
                  Text('月〜金（祝日除く）', style: _tableTextStyle),
                  Text('9:00-16:00', style: _tableTextStyle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyPolicyLink() {
    return GestureDetector(
      onTap: () {
        print('pressed');
      },
      child: Row(
        children: <Widget>[
          Text('・',
            style: TextStyle(
              color: paletteBlackColor,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text('プライバシーポリシー',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: paletteBlackColor,
              fontWeight: FontWeight.w300,
            ),
          ),
          Icon(Icons.call_made, color: kPaletteBorderColor, size: 20.0),
        ],
      ),
    );
  }
}