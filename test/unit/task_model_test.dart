import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/model/task.dart';

/*
ユニットテスト
 */

void main() {
  group('Task Model Tests', () {
    //　ここにテストケースを記述

    // test
    // 第一引数にはテストケースの説明
    // 第二引数には無名関数を渡す
    test('新しいタスクが正しく追加されるか', () {
      final task = Task(title: 'new task');
      print(task);

      /*
      Taskオブジェクトを作成し、そのtitleが指定したタイトルに一致するか、
      そしてisCompletedがデフォルトでfalseになっているかを検証しています。
       */



      // 期待値を検証するためにexpect使用
      // 第一引数にはテスト対象の値
      // 第二引数には期待される値を指定
      print(task.title);
      print(task.isCompleted);
      expect(task.title, 'new task');
      expect(task.isCompleted, false);

    });

    test('タスクの完了状態がトグルされるか', () {
      final task = Task(title: 'new task');

      /*
      新しいTaskオブジェクトを作成し、
      toggleCompleteメソッドを呼び出した後に
      isCompletedプロパティがtrueになるかを検証しています。
       */


      // ここでtrueにする
      task.toggleComplete();

      //　ログで確認できる
      print(task.isCompleted);

      expect(task.isCompleted, true);
    });
  });
}
