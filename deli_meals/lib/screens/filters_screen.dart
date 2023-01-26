import 'package:flutter/material.dart';

import '../models/filters.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final void Function(Filters filterData) saveFilters;
  final Filters filters;

  const FiltersScreen(
      {super.key, required this.saveFilters, required this.filters});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.filters.gluten;
    _vegetarian = widget.filters.vegetarian;
    _vegan = widget.filters.vegan;
    _lactoseFree = widget.filters.lactose;
    super.initState();
  }

  void handleSaveFilers() {
    widget.saveFilters(
      Filters(
        gluten: _glutenFree,
        lactose: _lactoseFree,
        vegan: _vegan,
        vegetarian: _vegetarian,
      ),
    );
  }

  Widget _buildSwitchListTile({
    required String title,
    required String subtitle,
    required bool currentValue,
    required Function(bool val) onChange,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: currentValue,
      onChanged: onChange,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            onPressed: handleSaveFilers,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal Selection',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                title: 'Gluten Free',
                subtitle: 'Only include gluten-free meals',
                currentValue: _glutenFree,
                onChange: (val) {
                  setState(() {
                    _glutenFree = val;
                  });
                },
              ),
              _buildSwitchListTile(
                title: 'Lactose Free',
                subtitle: 'Only include lactose-free meals',
                currentValue: _lactoseFree,
                onChange: (val) {
                  setState(() {
                    _lactoseFree = val;
                  });
                },
              ),
              _buildSwitchListTile(
                title: 'Vegetarian',
                subtitle: 'Only include vegetarian meals',
                currentValue: _vegetarian,
                onChange: (val) {
                  setState(() {
                    _vegetarian = val;
                  });
                },
              ),
              _buildSwitchListTile(
                title: 'Vegan',
                subtitle: 'Only include vegan meals',
                currentValue: _vegan,
                onChange: (val) {
                  setState(() {
                    _vegan = val;
                  });
                },
              ),
            ],
          ))
        ],
      ),
    );
  }
}
