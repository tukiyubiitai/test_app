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
    await tester.pump(); // タスク追加後の状態を反映させる

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

}
