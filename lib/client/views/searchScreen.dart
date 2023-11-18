import 'package:Tiwa_Oma/services/model/vendo_Model.dart';
import 'package:Tiwa_Oma/services/providers/searchApi.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.searchQuery, this.token});
  final searchQuery;
  final token;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<VendorModel> vendor = [];

  @override
  void initState() {
    super.initState();
    fetchSearchStylistData();
  }

  Future<void> fetchSearchStylistData() async {
    vendor =
        await SearchApi.fetchSearchStylistData(widget.token, widget.searchQuery)
            as List<VendorModel>;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.searchQuery),
      ),
    );
  }
}
