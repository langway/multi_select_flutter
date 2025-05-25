import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Multi Select',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Multi Select'),
    );
  }
}

class Animal {
  final int id;
  final String name;
  final String? imageUrl;

  Animal({required this.id, required this.name, this.imageUrl});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final List<Animal> _animals = [
    Animal(id: 1, name: "Lion", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 2, name: "Flamingo", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 3, name: "Hippo", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 4, name: "Horse", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 5, name: "Tiger", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 6, name: "Penguin", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 7, name: "Spider", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 8, name: "Snake", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 9, name: "Bear", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 10, name: "Beaver", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 11, name: "Cat", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 12, name: "Fish", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 13, name: "Rabbit", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 14, name: "Mouse", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 15, name: "Dog", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 16, name: "Zebra", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 17, name: "Cow", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 18, name: "Frog", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 19, name: "Blue Jay", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 20, name: "Moose", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 21, name: "Gecko", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 22, name: "Kangaroo", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 23, name: "Shark", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 24, name: "Crocodile", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 25, name: "Owl", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 26, name: "Dragonfly", imageUrl: 'assets/images/profile.jpg'),
    Animal(id: 27, name: "Dolphin", imageUrl: 'assets/images/profile.jpg'),
  ];
  final _items1 =
      _animals
          .map(
            (animal) => MultiSelectItem<Animal>(
              animal,
              animal.name,
              imageUrl: animal.imageUrl,
            ),
          )
          .toList();

  final _items2 =
      _animals
          .map(
            (animal) => MultiSelectItem<Animal>(
              animal,
              animal.name,
              imageUrl: animal.imageUrl,
            ),
          )
          .toList();
  final _items3 =
      _animals
          .map(
            (animal) => MultiSelectItem<Animal>(
              animal,
              animal.name,
              imageUrl: animal.imageUrl,
            ),
          )
          .toList();
  final _items4 =
      _animals
          .map(
            (animal) => MultiSelectItem<Animal>(
              animal,
              animal.name,
              imageUrl: animal.imageUrl,
            ),
          )
          .toList();

  final _items5 =
      _animals
          .map(
            (animal) => MultiSelectItem<Animal>(
              animal,
              animal.name,
              imageUrl: animal.imageUrl,
            ),
          )
          .toList();

  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              //################################################################################################
              // Rounded blue MultiSelectDialogField
              //################################################################################################
              MultiSelectDialogField(
                dialogFieldConfig: MultiSelectDialogFieldConfig<Animal>(
                  dialogType: DialogType.dialog,
                  title: Text("Animals1"),
                  panelConfig: MultiSelectPanelConfig<Animal>(
                    items: _items1,
                    itemsDisplayMode: ItemsDisplayMode.selected,
                    selectedColor: Colors.blue,
                  ),
                  dialogConfig: MultiSelectDialogConfig<Animal>(
                    panelConfig: MultiSelectPanelConfig<Animal>(
                      items: _items1,
                      itemViewType: ItemViewType.chip,
                      itemsDisplayMode: ItemsDisplayMode.all,
                      selectedColor: Colors.blue,
                      panelDecoration: ShapeDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          side: BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                  ),
                  buttonIcon: Icon(Icons.pets, color: Colors.blue),
                  buttonText: Text(
                    "Favorite Animals",
                    style: TextStyle(color: Colors.blue[800], fontSize: 16),
                  ),
                  onConfirm: (results) {
                    //_selectedAnimals = results;
                  },
                  buttonDecoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                ),
              ),
              SizedBox(height: 50),
              //################################################################################################
              // This MultiSelectBottomSheetField has no decoration, but is instead wrapped in a Container that has
              // decoration applied. This allows the ChipDisplay to render inside the same Container.
              //################################################################################################
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.4),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    MultiSelectBottomSheetField<Animal>(
                      dialogFieldConfig: MultiSelectDialogFieldConfig<Animal>(
                        title: Text("Animals2"),
                        searchable: true,
                        initialChildSize: 0.4,
                        buttonText: Text("Favorite Animals"),
                        panelConfig: MultiSelectPanelConfig<Animal>(
                          items: _items2,
                        ),
                        dialogConfig: MultiSelectDialogConfig<Animal>(
                          panelConfig: MultiSelectPanelConfig<Animal>(
                            items: _items2,
                          ),
                        ),
                      ),
                    ),
                    !hasSelected(_items2)
                        ? Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "None selected",
                            style: TextStyle(color: Colors.black54),
                          ),
                        )
                        : Container(),
                  ],
                ),
              ),
              SizedBox(height: 40),
              //################################################################################################
              // MultiSelectBottomSheetField with validators
              //################################################################################################
              MultiSelectDialogField<Animal>(
                key: _multiSelectKey,
                dialogFieldConfig: MultiSelectDialogFieldConfig<Animal>(
                  title: Text("Animals3"),
                  dialogType: DialogType.bottomSheet,
                  searchable: true,
                  initialChildSize: 0.7,
                  maxChildSize: 0.95,
                  buttonText: Text("Favorite Animals"),
                  onConfirm: (values) {},
                  panelConfig: MultiSelectPanelConfig<Animal>(
                    items: _items3,
                    itemsDisplayMode: ItemsDisplayMode.selected,
                    onTap: (item) {
                      setState(() {
                        // do nothing, but can refresh the UI immediately.
                        // you can use _items1 as it's select mode changed;
                      });
                      _multiSelectKey.currentState!.validate();
                    },
                  ),
                  dialogConfig: MultiSelectDialogConfig<Animal>(
                    panelConfig: MultiSelectPanelConfig<Animal>(
                      items: _items3,
                      itemViewType: ItemViewType.checkBoxList,
                      listType: ListTypes.verticalList,
                      onTap: (item) {
                        setState(() {
                          // do nothing, but can refresh the UI immediately.
                          // you can use _items1 as it's select mode changed;
                        });
                        _multiSelectKey.currentState!.validate();
                      },
                    ),
                  ),
                ),
                validator: (values) {
                  if (values == null || values.isEmpty) {
                    return "Required";
                  }
                  List<String> names = values.map((e) => e.name).toList();
                  if (names.contains("Frog")) {
                    return "Frogs are weird!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
              //################################################################################################
              // MultiSelectChipField
              //################################################################################################
              MultiSelectField(
                fieldConfig: MultiSelectFieldConfig<Animal>(
                  panelConfig: MultiSelectPanelConfig<Animal>(
                    itemViewType: ItemViewType.image,
                    listType: ListTypes.block,
                    items: _items4,

                    selectedColor: Colors.blue.withOpacity(0.5),
                    onTap: (value) {
                      //_selectedAnimals4 = values;
                    },
                  ),
                  title: Text("Animals4"),
                  selectedItemsTextStyle: TextStyle(color: Colors.blue[800]),
                  headerDecoration: ShapeDecoration(
                    color: Colors.red.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blue[700]!, width: 1.8),
                    ),
                  ),
                ),
                initialValue: [_animals[4], _animals[7], _animals[9]],
                // itemViewType: MultiSelectitemViewType.Image,
              ),
              SizedBox(height: 40),
              //################################################################################################
              // MultiSelectDialogField with initial values
              //################################################################################################
              MultiSelectDialogField(
                dialogFieldConfig: MultiSelectDialogFieldConfig<Animal>(
                  panelConfig: MultiSelectPanelConfig<Animal>(
                    items: _items5,
                    itemViewType: ItemViewType.checkBox,
                    itemsDisplayMode: ItemsDisplayMode.cascade,
                    checkBoxBorderShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(15.0),
                        bottom: Radius.circular(15.0),
                      ),
                    ),
                  ),
                  dialogConfig: MultiSelectDialogConfig<Animal>(
                    panelConfig: MultiSelectPanelConfig<Animal>(
                      items: _items5,
                      itemViewType: ItemViewType.checkBox,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool hasSelected(List<MultiSelectItem<Animal>> items) {
    for (var item in items) {
      if (item.selected) {
        return true;
      }
    }
    return false;
  }
}
