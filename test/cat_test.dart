import 'package:mockito/mockito.dart';
import 'package:simple_feed_app/practice/cat.dart';
import 'package:test/test.dart';

class MockCatClass extends Mock implements Cat {}

void main() {
  var cat = MockCatClass();

  cat.sound();
  verify(cat.sound());
  test('testing', ()  {
    when(cat.sound()).thenReturn("moew");
    expect(cat.sound(),"puff");
  });

//  when(cat.lives).thenThrow(RangeError('Boo'));
//  expect(() => cat.lives, throwsRangeError);
}
