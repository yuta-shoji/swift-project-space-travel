//
//  generalUtils.swift
//  SpaceApp
//
//  Created by 庄子優太 on 2022/06/20.
//

import UIKit

struct GeneralUtils {
    func reloadView(view: UIViewController) -> Void {
        print("reload")
        view.view.endEditing(true)
        view.loadView()
        view.viewDidLoad()
    }
    
    func tapOutside(view: UIViewController) {
        view.dismiss(animated: true)
    }
    
    func makeToolBar(classes: UIViewController, toolbar: UIToolbar, datePicker: UIDatePicker, repo: Dates) -> UIDatePicker {
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: classes, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: classes, action: Selector(("done")))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: classes, action: #selector(Progress.cancel))
        toolbar.setItems([spacelItem, cancelItem, doneItem], animated: true)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        datePicker.date = formatter.date(from: repo.getDate())!
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }
}
