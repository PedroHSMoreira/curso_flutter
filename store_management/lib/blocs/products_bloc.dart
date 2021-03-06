import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/subjects.dart';

class ProductsBloc extends BlocBase {
  final _dataController = BehaviorSubject<Map>();
  final _loadingController = BehaviorSubject<bool>();
  final _createdController = BehaviorSubject<bool>();

  Stream<Map> get outData => _dataController.stream;
  Stream<bool> get outLoadig => _loadingController.stream;
  Stream<bool> get outCreated => _createdController.stream;

  String categoryId;
  DocumentSnapshot product;

  Map<String, dynamic> unsavedData;

  ProductsBloc({this.categoryId, this.product}) {
    if (product != null) {
      unsavedData = Map.of(product.data);
      unsavedData["images"] = List.of(product.data["images"]);
      unsavedData["sizes"] = List.of(product.data["sizes"]);

      _createdController.add(true);
    } else {
      unsavedData = {
        "title": null,
        "description": null,
        "price": null,
        "images": [],
        "sizes": []
      };

      _createdController.add(false);
    }

    _dataController.add(unsavedData);
  }

  void saveImages(List images) {
    unsavedData["images"] = images;
  }

  void saveTitle(String title) {
    unsavedData["title"] = title;
  }

  void saveDescription(String description) {
    unsavedData["description"] = description;
  }

  void saveprice(String price) {
    unsavedData["price"] = double.parse(price);
  }

   void saveSizes(List sizes) {
    unsavedData["sizes"] = sizes;
  }

  Future<bool> saveProduct() async {
    _loadingController.add(true);

    try {
      if (product != null) {
        await _uploadImages(product.documentID);
        await product.reference.updateData(unsavedData);
      } else {
        DocumentReference documentReference = await Firestore.instance
            .collection("products")
            .document(categoryId)
            .collection("items")
            .add(Map.from(unsavedData)..remove("images"));
        await _uploadImages(documentReference.documentID);
        await documentReference.updateData(unsavedData);
      }

      _createdController.add(true);
      _loadingController.add(false);

      return true;
    } catch (e) {
      _loadingController.add(false);

      return true;
    }
  }

  void deleteProduct() {
    product.reference.delete();
  }

  Future _uploadImages(String productId) async {
    for (int i = 0; i < unsavedData["images"].length; i++) {
      if (unsavedData["images"][i] is String) continue;

      StorageUploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(categoryId)
          .child(productId)
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(unsavedData["images"][i]);

      StorageTaskSnapshot snapshot = await uploadTask.onComplete;
      String downlaodUrl = await snapshot.ref.getDownloadURL();

      unsavedData["images"][i] = downlaodUrl;
    }
  }

  @override
  void dispose() {
    _dataController.close();
    _loadingController.close();
    _createdController.close();
    super.dispose();
  }
}
