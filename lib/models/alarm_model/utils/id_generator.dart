import 'dart:math';

int generateUniqueIntId() {

  int? uniqueId; 

  while (uniqueId == null || uniqueId.bitLength >=32) {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    int timestampBits = timestamp & ((1 << 21) - 1);
    int random = Random().nextInt(1 << 10); // 0 to 1023
    uniqueId = (timestampBits << 10) | random;
  }
  
  return uniqueId;
}