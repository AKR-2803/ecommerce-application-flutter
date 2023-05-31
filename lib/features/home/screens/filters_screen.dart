import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce_major_project/features/home/providers/filter_provider.dart';

enum FilterType { atoZ, priceLtoH, priceHtoL }

class FilterScreen extends StatefulWidget {
  FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        // automaticallyImplyLeading: true,
        // leading: Text(("Filters")),
        leadingWidth: 0,
        leading: const SizedBox.shrink(),
        title: const Text(
          "Filters",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontStyle: FontStyle.normal),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"))
        ],
      ),

      // appBar: AppBar(leading: Text("Filters"), actions: [
      //   TextButton(
      //       onPressed: () => Navigator.of(context).pop(), child: Text("Close"))
      // ]),
      //  ,
      body: FiltersAvailable(),
    );
  }
}

class FiltersAvailable extends StatefulWidget {
  FiltersAvailable({super.key});

  @override
  State<FiltersAvailable> createState() => _FiltersAvailableState();
}

class _FiltersAvailableState extends State<FiltersAvailable> {
  FilterType? _character;
  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);
    // FilterType? _character = widget.filterNumber == null
    //     ? null
    //     : getFilterType(widget.filterNumber!);

    return Column(
      children: <Widget>[
        RadioListTile(
          activeColor: Colors.deepPurple.shade700,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.black, width: .1)),
          title: const Text('a-z'),
          value: FilterType.atoZ,
          groupValue: _character,
          onChanged: (FilterType? value) {
            setState(() {
              _character = value;
            });
          },
        ),
        RadioListTile(
          activeColor: Colors.deepPurple.shade700,
          title: const Text('Price Low to High'),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.black, width: .1)),
          value: FilterType.priceLtoH,
          groupValue: _character,
          onChanged: (FilterType? value) {
            setState(() {
              _character = value;
            });
          },
        ),
        RadioListTile(
          activeColor: Colors.deepPurple.shade700,
          title: const Text('Price High to Low'),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.black, width: .1)),
          value: FilterType.priceHtoL,
          groupValue: _character,
          onChanged: (FilterType? value) {
            setState(() {
              _character = value;
            });
          },
        ),
        TextButton(
            onPressed: () {
              if (_character == FilterType.atoZ) {
                filterProvider.setFilterNumber(1);
              } else if (_character == FilterType.priceLtoH) {
                filterProvider.setFilterNumber(2);
              } else if (_character == FilterType.priceHtoL) {
                filterProvider.setFilterNumber(3);
              }
              Navigator.pop(context);
            },
            child: Text(
              "\nSubmit",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.deepPurple.shade700,
                  fontSize: 16),
            ))
      ],
    );
  }

  // FilterType? getFilterType(int filterNumber) {
  //   switch (filterNumber) {
  //     case 0:
  //       return FilterType.atoZ;
  //     case 1:
  //       return FilterType.priceLtoH;
  //     case 2:
  //       return FilterType.priceLtoH;
  //     default:
  //       return null;
  //   }
  // }
}
