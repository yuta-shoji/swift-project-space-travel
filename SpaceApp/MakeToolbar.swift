//
//  MakeToolbar.swift
//  SpaceApp
//
//  Created by 庄子優太 on 2022/06/20.
//

import UIKit
//
//func makeToolBar(classes: UIViewController, view: UIView, field: UITextField, repo: Dates, done: () -> (), cancel: () -> ()) -> UIDatePicker {
//
//    var datePicker: UIDatePicker = UIDatePicker()
//    //日付入力フォーム作成
//    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
//    let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: classes, action: nil)
//    let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: classes, action: #selector(done))
//    let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: classes, action: #selector(cancel))
//    toolbar.setItems([spacelItem, cancelItem, doneItem], animated: true)
//    let formatter = DateFormatter()
//    formatter.dateFormat = "yyyy-MM-dd"
//    datePicker.date = formatter.date(from: repo.getDate())!
//    datePicker.datePickerMode = .date
//    datePicker.preferredDatePickerStyle = .wheels
//    field.inputView = datePicker
//    field.inputAccessoryView = toolbar
//
//    return datePicker
//}
//

//選択した日付のデータが存在しない場合の処理
class TodayClass {
    class func nonExistAlert () -> UIAlertController {
        var alert: UIAlertController!
        alert = UIAlertController(title: "この日にデータは存在しません", message: "他の日付を見てみよう！", preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.cancel,
            handler: nil
        )
        alert.addAction(alertAction)
        return alert
    }
}
