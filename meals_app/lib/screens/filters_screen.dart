import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const ROUTE_NAME = 'filters-screen';

  final Function setFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.setFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState(setFilters);
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  final Function setFilters;

  _FiltersScreenState(this.setFilters);

  Widget _buildSwitchListTitle(
      {@required String tile,
      @required String subtitle,
      @required bool value,
      @required Function onChangeValue}) {
    return SwitchListTile(
      title: Text(tile),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChangeValue,
    );
  }

  void _saveFilters() {
    final selectedFilters = {
      'gluten': _glutenFree,
      'lactose': _lactoseFree,
      'vegan': _vegan,
      'vegetarian': _vegetarian,
    };

    setFilters(selectedFilters);
  }

  @override
  void initState() {
    super.initState();

    final filters = widget.currentFilters;
    _glutenFree = filters['gluten'];
    _vegetarian = filters['vegetarian'];
    _vegan = filters['vegan'];
    _lactoseFree = filters['lactose'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filters',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
            ),
            onPressed: _saveFilters,
            tooltip: 'Save filters',
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTitle(
                  tile: 'Gluten-free',
                  subtitle: 'Only include gluten-free meals.',
                  value: _glutenFree,
                  onChangeValue: (value) {
                    setState(() {
                      _glutenFree = value;
                    });
                  },
                ),
                _buildSwitchListTitle(
                  tile: 'Vegetarian',
                  subtitle: 'Only include vegetarian meals.',
                  value: _vegetarian,
                  onChangeValue: (value) {
                    setState(() {
                      _vegetarian = value;
                    });
                  },
                ),
                _buildSwitchListTitle(
                  tile: 'Vegan',
                  subtitle: 'Only include vegan meals.',
                  value: _vegan,
                  onChangeValue: (value) {
                    setState(() {
                      _vegan = value;
                    });
                  },
                ),
                _buildSwitchListTitle(
                  tile: 'Lactose-free',
                  subtitle: 'Only include lactose-free meals.',
                  value: _lactoseFree,
                  onChangeValue: (value) {
                    setState(() {
                      _lactoseFree = value;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
