Map<String, dynamic> convertMap(Map<dynamic, dynamic> originalMap) {
  Map<String, dynamic> convertedMap = {};
  originalMap.forEach((key, value) {
    if (key is String) {
      convertedMap[key] = value;
    } else {
      convertedMap[key.toString()] = value;
    }
  });
  return convertedMap;
}
