import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stal/services/address_search.dart';
import 'package:stal/services/places_service.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stal/services/my_flutter_app_icons.dart';
import 'package:stal/models/rawmaterial_models.dart';
import 'package:stal/firestore_service.dart';
import 'package:stal/widgets/header_delegate.dart';
import 'package:stal/constants/constants.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  SalesPageListState createState() => SalesPageListState();
}

class SalesPageListState extends State<SalesPage> {
  String _searchText = "";
  List<RawMaterial> _rawMaterials = [];
  List<RawMaterial> cartItems = [];
  List<double> enteredWeights = [];
  List<double> enteredLengths = [];
  List<double> enteredPrices = [];
  final Map<String, TextEditingController> _controllers = {};
  final TextEditingController _addressController = TextEditingController();
  String? _savedAddress;
  final User? _user = FirebaseAuth.instance.currentUser;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onSearchTextChanged);
    _fetchData();
    _loadAddressFromFirebase();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    _addressController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    setState(() {
      _searchText = _textEditingController.text;
    });
  }

  void _removeItem(int index) {
    setState(() {
      if (index >= 0 && index < cartItems.length) {
        cartItems.removeAt(index);
        enteredWeights.removeAt(index);
        enteredLengths.removeAt(index);
        enteredPrices.removeAt(index);
        _controllers.remove(cartItems[index].name);
      }
    });
    Navigator.of(context).pop();
    _showShoppingCart(context);
  }

  void _addItem(RawMaterial material, double weight, double length, double price) {
    setState(() {
      cartItems.add(material);
      enteredWeights.add(weight);
      enteredLengths.add(length);
      enteredPrices.add(price);
    });
  }

  Future<void> _fetchData() async {
    try {
      QuerySnapshot rawMaterialSnapshot =
      await FirebaseFirestore.instance.collection('raw_materials').get();
      List<RawMaterial> rawMaterials = rawMaterialSnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return RawMaterial(
          name: data['name'],
          weight: (data['weight'] as num).toDouble(),
          length: (data['length'] as num).toDouble(),
          price: (data['price'] as num).toDouble(),
        );
      }).toList();
      setState(() {
        _rawMaterials = rawMaterials;
      });
    } catch (e) {
      debugPrint("Error fetching data: $e");
    }
  }
  final List<String> dwuteowniki = ['IPE', 'IPN', 'HEA', 'HEB', 'HEC', 'HEM'];
  final List<String> ceowniki = ['UPE', 'UPN'];
  List<RawMaterial> _filterItems() {
    List<RawMaterial> filteredItems;

    switch (selectedCategoryIndex) {
      case 1:
        filteredItems = _rawMaterials
            .where((material) => dwuteowniki.any((prefix) => material.name.startsWith(prefix)))
            .toList(); // I-Beams
        break;
      case 2:
        filteredItems = _rawMaterials
            .where((material) => ceowniki.any((prefix) => material.name.startsWith(prefix)))
            .toList(); // Angles
        break;
      case 3:
        filteredItems = _rawMaterials
            .where((material) => material.name.startsWith('SHEET'))
            .toList(); // Sheets
        break;
      case 4:
        filteredItems = _rawMaterials
            .where((material) => material.name.startsWith('PIPE'))
            .toList(); // Pipes
        break;
      case 5:
        filteredItems = _rawMaterials
            .where((material) => material.name.startsWith('C'))
            .toList(); // Channels
        break;
      case 6:
        filteredItems = _rawMaterials
            .where((material) => material.name.startsWith('TUBE'))
            .toList(); // Tubes
        break;
      case 7:
        filteredItems = _rawMaterials
            .where((material) => material.name.startsWith('BAR'))
            .toList(); // Bars
        break;
      case 8:
        filteredItems = _rawMaterials
            .where((material) => material.name.startsWith('PLATE'))
            .toList(); // Plates
        break;
      default:
        filteredItems = _rawMaterials; // All products
    }

    if (_searchText.isNotEmpty) {
      filteredItems = filteredItems
          .where((material) =>
          material.name.toLowerCase().contains(_searchText.toLowerCase()))
          .toList();
    }

    filteredItems.sort((a, b) => a.name.compareTo(b.name));
    return filteredItems;
  }

  Future<void> _saveCartToFirebase() async {
    if (_user == null) return;

    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (int i = 0; i < cartItems.length; i++) {
        DocumentReference ref = FirebaseFirestore.instance.collection('products').doc();
        batch.set(ref, {
          'name': cartItems[i].name,
          'weight': enteredWeights[i],
          'length': enteredLengths[i],
          'price': enteredPrices[i],
          'userId': _user.uid,
          'location': _addressController.text,
        });
      }
      await batch.commit();
    } catch (e) {
      debugPrint("Error saving cart: $e");
    }
  }

  Future<void> _loadAddressFromFirebase() async {
    if (_user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(_user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            _savedAddress = userDoc.get('location') as String?;
            _addressController.text = _savedAddress ?? '';
          });
        }
      } catch (e) {
        if (kDebugMode) {
          print('Failed to load address: $e');
        }
      }
    }
  }

  void _showLocation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Adres magazynu'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  _savedAddress != null
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Adres: $_savedAddress',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _savedAddress = null;
                            _addressController.text = '';
                          });
                        },
                        child: const Text('Edit'),
                      ),
                    ],
                  )
                      : TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.home, color: Color.fromRGBO(249, 255, 251, 1.0)),
                      hintText: "Adres magazynu...",
                    ),
                    readOnly: true,
                    onTap: () async {
                      final sessionToken = const Uuid().v4();
                      final Suggestion? result = await showSearch(
                        context: context,
                        delegate: AddressSearch(sessionToken),
                      );
                      if (result != null) {
                        setState(() {
                          _addressController.text = result.description;
                          _savedAddress = _addressController.text;
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    _saveCartToFirebase(); // Save cart data to Firebase
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save Cart'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showShoppingCart(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final double screenHeight = MediaQuery.of(context).size.height;
        final double dialogHeight = screenHeight * (5 / 6);

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: dialogHeight,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final material = cartItems[index];
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Text(
                                  material.name,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: '0 kg',
                                      contentPadding: EdgeInsets.all(4.0),
                                    ),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    initialValue: enteredWeights[index].toStringAsFixed(2),
                                    style: const TextStyle(fontSize: 14),
                                    onChanged: (value) {
                                      setState(() {
                                        double? tempWeight = double.tryParse(value);
                                        if (tempWeight != null) {
                                          enteredWeights[index] = tempWeight;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: '0.0 mb',
                                      contentPadding: EdgeInsets.all(4.0),
                                    ),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    initialValue: enteredLengths[index].toStringAsFixed(2),
                                    style: const TextStyle(fontSize: 14),
                                    onChanged: (value) {
                                      setState(() {
                                        double? tempLength = double.tryParse(value);
                                        if (tempLength != null) {
                                          enteredLengths[index] = tempLength;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: '0.0 zł/kg',
                                      contentPadding: EdgeInsets.all(4.0),
                                    ),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    initialValue: enteredPrices[index].toStringAsFixed(2),
                                    style: const TextStyle(fontSize: 14),
                                    onChanged: (value) {
                                      setState(() {
                                        double? tempPrice = double.tryParse(value);
                                        if (tempPrice != null) {
                                          enteredPrices[index] = tempPrice;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_shopping_cart, size: 20),
                            onPressed: () {
                              _removeItem(index);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the modal sheet
                        },
                        child: const Text('Close'),
                      ),
                      ElevatedButton(
                        onPressed: () => _showLocation(context),
                        child: const Text('Dodaj adres magazynu'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(categoryIcons.length, (index) {
              return IconButton(
                icon: Icon(categoryIcons[index]),
                onPressed: () {
                  setState(() {
                    selectedCategoryIndex = index;
                  });
                },
                color: selectedCategoryIndex == index
                    ? Colors.black
                    : Colors.grey,
              );
            }),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: "Szukaj produktów",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchText.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _textEditingController.clear();
                    _onSearchTextChanged();
                  },
                )
                    : null,
              ),
            ),
          ),
        ),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showShoppingCart(context);
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  Widget _buildBody() {
    List<String> headerTitles = ['Nazwa', 'Waga', 'Długość', 'Cena', ' '];
    return Column(
      children: [
        HeaderDelegate(titles: headerTitles),

        Expanded(
          child: ListView.builder(
            itemCount: _filterItems().length,
            itemBuilder: (BuildContext context, int index) {
              final filteredItem = _filterItems()[index];
              TextEditingController weightController =
                  _controllers[filteredItem.name] ?? TextEditingController();
              TextEditingController lengthController = TextEditingController();
              TextEditingController priceController = TextEditingController();

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text(
                            filteredItem.name,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: TextFormField(
                            controller: weightController,
                            decoration: const InputDecoration(
                              hintText: '0.0 kg',
                              contentPadding: EdgeInsets.all(4.0),
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) {
                              double? parsedValue = double.tryParse(value);
                              if (parsedValue == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter a valid number'),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: TextFormField(
                            controller: lengthController,
                            decoration: const InputDecoration(
                              hintText: '0.0 mb',
                              contentPadding: EdgeInsets.all(4.0),
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) {
                              double? parsedValue = double.tryParse(value);
                              if (parsedValue == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter a valid number'),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: TextFormField(
                            controller: priceController,
                            decoration: const InputDecoration(
                              hintText: '0.0 zł/kg',
                              contentPadding: EdgeInsets.all(4.0),
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 14),
                            onChanged: (value) {
                              double? parsedValue = double.tryParse(value);
                              if (parsedValue == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter a valid number'),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        double? weight = double.tryParse(weightController.text);
                        double? length = double.tryParse(lengthController.text);
                        double? price = double.tryParse(priceController.text);
                        if (weight != null && length != null && price != null) {
                          _addItem(filteredItem, weight, length, price);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter valid weight, length, and price'),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
