import '../utils/exporter.dart';

TextFormField formTextfield(
    {required TextEditingController controller,
    required IconData icon,
    required label,
    String? Function(String?)? validator}) {
  return TextFormField(
      controller: controller,
      decoration: InputDecoration(prefixIcon: Icon(icon), labelText: label),
      validator: validator);
}
