part of 'shared.dart';

Future<File> getImagee() async {
  final picker = ImagePicker();
  var image = await picker.getImage(source: ImageSource.gallery);
  return File(image.path);
}

// Setelah di upload, kita ingin mengembalikan download URL nya dari file gambar nya
Future<String> uploadImage(File image) async {
  // pertama kita ambil nama file nya blablabla.jpg nya
  String fileName = basename(image.path);

  StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
  // ini buat upload file nya
  StorageUploadTask task = ref.putFile(image);
  // ini untuk kembaliannya
  StorageTaskSnapshot snapshot = await task.onComplete;
  // kalo sudah kita akan return download URL nya
  return await snapshot.ref.getDownloadURL();
}
