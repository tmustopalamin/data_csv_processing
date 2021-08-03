import 'dart:io';

void main(List<String> arg) {
  if (arg.isEmpty) {
    print('Usage: dart total.dart <inputFile.csv>');
    exit(1);
  }

  final inputFile = arg.first;
  final lines = File(inputFile).readAsLinesSync();
  var totalDurationByTag = <String, double>{};
  lines.removeAt(0);
  for (var line in lines) {
    var values = line.split(',');

    final durationStr = values[3].replaceAll('"', '');
    final duration = double.parse(durationStr);

    final tag = values[5].replaceAll('"', '');

    final previousTotal = totalDurationByTag[tag];
    if (previousTotal == null) {
      totalDurationByTag[tag] = duration;
    } else {
      totalDurationByTag[tag] = previousTotal + duration;
    }
  }

  var total = 0.0;
  for (var entry in totalDurationByTag.entries) {
    total += entry.value;
    final durationFormatted = entry.value.toStringAsFixed(1);
    final tag = entry.key == '' ? 'Unallocated' : entry.key;
    print('$tag : ${durationFormatted}h');
  }

  print('Overal total: ${total.toStringAsFixed(1)}h');
}

//lines = readFile(inputFile)
//durationByTag = empty map
//lines.removeFirst
//for (line in lines)
  //values = line.split(',')
  //duration = values[3]
  //tag = values[5]
  //update(durationByTag[tag], duration)
//end
//printAll(durationByTag)

