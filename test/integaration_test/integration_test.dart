import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test_app/main.dart' as app;


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();


    group('ToDoリスト統合テスト', () {
      testWidgets('タスクの追加、完了、削除フロー', (tester) async {
        app.main();
        await tester.pumpAndSettle();

        // タスクの追加
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), 'タスク1');
        await tester.tap(find.text('追加'));
        await tester.pumpAndSettle();
        expect(find.text('タスク1'), findsOneWidget);

        // タスクの完了
        await tester.tap(find.text('タスク1'));
        await tester.pumpAndSettle();
        final TextStyle textStyle = tester.widget<Text>(find.text('タスク1')).style!;
        expect(textStyle.decoration, TextDecoration.lineThrough);
        // 完了したタスクのスタイル変更などを確認

        // タスクの削除
        await tester.tap(find.byIcon(Icons.delete));
        await tester.pumpAndSettle();
        expect(find.text('タスク1'), findsNothing);
      });


      testWidgets('複数のタスクを追加し、異なる順番で完了または削除', (tester) async {
        app.main();
        await tester.pumpAndSettle();

        // 1つ目のタスクを追加
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle(); // ダイアログが開くまで待つ
        await tester.enterText(find.byType(TextField), 'タスク1');
        await tester.tap(find.text('追加'));
        await tester.pump();

        // 2つ目のタスクを追加
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle(); // ダイアログが開くまで待つ
        await tester.enterText(find.byType(TextField), 'タスク2');
        await tester.tap(find.text('追加'));
        await tester.pump();

        // 1つ目のタスクを完了（タップ）する
        await tester.tap(find.text('タスク1'));
        await tester.pumpAndSettle();

        // 2つ目のタスクを削除する
        // 注: 削除ボタンの正確な特定方法は、アプリのUI構造に依存します。
        // 以下は一例です。実際のアプリに合わせて適切なfinderを使用してください。
        await tester.tap(find.byIcon(Icons.delete).at(1));
        await tester.pumpAndSettle();


        // 検証: 1つ目のタスクが完了状態になっていること（UIによって異なるため、ここでは具体的な検証方法を示しません）
        // 検証: 2つ目のタスクがリストから削除されていること
        final TextStyle textStyle = tester.widget<Text>(find.text('タスク1')).style!;
        print(textStyle);
        expect(textStyle.decoration, TextDecoration.lineThrough);
        expect(find.text('タスク2'), findsNothing);
      });
    });
}
