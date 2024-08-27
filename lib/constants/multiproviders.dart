import 'package:boat_service_hygwell/providers/add_on_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> multiProviders = [
  // Add-On Provider
  ChangeNotifierProvider<AddOnProvider>(create: (context) => AddOnProvider()),
];
