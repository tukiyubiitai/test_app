import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/main.dart';

void main() {
  // 第一引数にはテストの説明
  // 第二引数にはwidgetを操作してテストを実行するコードブロックを非同期関数として渡す
  testWidgets('タスク追加ボタンを押してダイアログが開くかテスト', (WidgetTester tester) async {
    // アプリをビルドして、テストを実行
    // pumpWidgetスタートラインを設定
    await tester.pumpWidget(MyApp());

    // フローティングアクションボタンを探す
    //  Icons.add アイコンを持つボタンが正確に1つだけ存在することを確認
    // findメソッドを通じて特定のウィジェットを検索し、そのウィジェットが画面上に1つだけ存在することを確認
    expect(find.byIcon(Icons.add), findsOneWidget);

    // 指定されたアイコンを持つウィジェットをタップします
    await tester.tap(find.byIcon(Icons.add));
    // ウィジェットツリーの再構築と再描画
    await tester.pump();

    // ダイアログが表示されるか確認
    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('追加ボタンでタスクが追加される', (WidgetTester tester) async {
    // テスト対象のウィジェットをレンダリング
    await tester.pumpWidget(MyApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle(); // 新しい画面やダイアログが完全に表示されるまで待つ

    await tester.enterText(find.byType(TextField), 'タスク1');  // 例: ユーザーがタスク追加ボタンをタップする操作をシミュレート
    final Finder addButtonFinder = find.widgetWithText(ElevatedButton, '追加');
    await tester.tap(addButtonFinder);    // ElevatedButton
    await tester.pumpAndSettle(); // 新しい画面やダイアログが完全に表示されるまで待つ

    expect(find.text('タスク1'), findsOneWidget);
});

  testWidgets('タスク削除ボタンをタップするとタスクが削除される', (WidgetTester tester) async {
    // テスト対象のウィジェットをレンダリング
    await tester.pumpWidget(MyApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle(); // 新しい画面やダイアログが完全に表示されるまで待つ

    await tester.enterText(find.byType(TextField), 'タスク1');  // 例: ユーザーがタスク追加ボタンをタップする操作をシミュレート
    final Finder addButtonFinder = find.widgetWithText(ElevatedButton, '追加');
    await tester.tap(addButtonFinder);    // ElevatedButton
    await tester.pumpAndSettle(); // 新しい画面やダイアログが完全に表示されるまで待つ


    // ここでタスクが追加された
    expect(find.text('タスク1'), findsOneWidget);


    // タスク削除ボタンをタップ
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle(); // アニメーションや状態更新を待つ

    // タスクがリストから削除されたことを検証
    expect(find.text('タスク1'), findsNothing);
  });

  testWidgets('タスクの完了/未完了の切り替えテスト', (WidgetTester tester) async {
    // ToDoListScreenウィジェットをレンダリング
    await tester.pumpWidget(MyApp());

    // 新しいタスクを追加
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); // ダイアログが開くのを待つ

    // ダイアログ内のテキストフィールドにタスク名を入力
    await tester.enterText(find.byType(TextField), 'テストタスク');
    // "追加"ボタンをタップしてタスクをリストに追加
    await tester.tap(find.widgetWithText(ElevatedButton, '追加'));
    await tester.pump(); // タスク追加後の状態を反映させる

    // タスクがリストに追加されたことを確認
    // テキストを含むウィジェットが画面上に正確に一つ存在するかを検証
    expect(find.text('テストタスク'), findsOneWidget);
    expect(find.byType(ListTile), findsOneWidget);

    // タスクをタップして完了状態をトグル
    await tester.tap(find.text('テストタスク'));
    await tester.pump(); // 状態の更新を反映させる

    // タスクが完了状態（取り消し線が引かれた状態）になっていることを検証
    final TextStyle textStyle = tester.widget<Text>(find.text('テストタスク')).style!;
    expect(textStyle.decoration, TextDecoration.lineThrough);
  });


}

/*
widget testで追加ボタンでタスクが追加される、タスク削除ボタンをタップするとタスクが削除される、タスクの完了/未完了の切り替えテスト
 */