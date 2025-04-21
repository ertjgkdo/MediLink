import '../utils/exporter.dart';

TextFormField formTextfield(
    {required TextEditingController controller,
    IconData? icon,
    required label,
    String? prefixtext,
    String? Function(String?)? validator}) {
  return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          prefixText: prefixtext,
          prefixStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      validator: validator);
}
