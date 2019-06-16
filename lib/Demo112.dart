import 'dart:math' as math;
printNumber(num aNumber) {
  print('The number is $aNumber.'); // 在控制台打印内容。
}

main() {
  var number = 42; // 定义并初始化一个变量。
  printNumber(number); // 调用一个方法。
  var  clipRectSize=2.0*(64/math.sqrt2);
  print(clipRectSize);
}