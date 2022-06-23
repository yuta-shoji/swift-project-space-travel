import UIKit
import SVProgressHUD

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var apiImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var explanationTextView: UITextView!
    
    private let dateRepo = InMemoryDateRepository()
    var datePicker: UIDatePicker = UIDatePicker()
    var alert: UIAlertController!
    let generalUtils = GeneralUtils()
    let dateUtils = DateUtils()
    
    //インスタンスの各種設定
    func settingInstance() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
        dateTextField.text = dateRepo.getDate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingInstance()
        
        //日付入力フォーム作成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        datePicker = generalUtils.makeToolBar(classes: self, toolbar: toolbar, datePicker: datePicker, repo: dateRepo)
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = toolbar
        
        alert = TodayClass.nonExistAlert()
        
        //引数に文字列をqueryとして受け取る関数
        func searchNasaApi(query: String, url: String) {
            SVProgressHUD.show(withStatus: "Now Loading...")
            //urlオブジェクトを作成(型：URL)
            let url = URL(string: url + query)!
            //HTTPリクエストを作成
            let request = URLRequest(url: url)
            let decoder: JSONDecoder = JSONDecoder()
            //URLSession.sharedで、URLに指定されたエンドポイントとのデータのやり取りができる
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let nasa: TodaysSpaseStruct = try decoder.decode(TodaysSpaseStruct.self, from: data)
                    let imageUrl = URL(string: nasa.url)
                    do {
                        let data = try Data(contentsOf: imageUrl!)
                        DispatchQueue.main.async {
                            SVProgressHUD.dismiss()
                            self.titleLabel.text = nasa.title
                            self.explanationTextView.text = nasa.explanation
                            self.apiImage.image = UIImage(data: data)!
                        }
                    } catch let err {
                        print("Error : \(err.localizedDescription)")
                        fatalError()
                    }
                } catch let e {
                    print("JSON Decode Error :\(e)")
                    DispatchQueue.main.async {
                        self.apiImage.image = UIImage(named: "noImage")
                        self.titleLabel.text = ""
                        self.explanationTextView.text = ""
                    }
                    //アラートコントローラーを表示する。
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.present(self.alert, animated: true, completion:{
                            self.alert.view.superview?.isUserInteractionEnabled = true
                            self.alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self.generalUtils, action: Selector(("tapOutside"))))
                        })
                    }
                }
            }
            task.resume()
        }
        searchNasaApi(query: "", url: "https://api.nasa.gov/planetary/apod?api_key=oKsAwOzVHXn306L3kwemIf38VgyBEcbgL6QVDl9u&date=\(dateRepo.getDate())")
    }
    
    @objc func done() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let newDate = formatter.string(from: datePicker.date)
        dateTextField.text = newDate
        dateRepo.change(date: newDate)
        generalUtils.reloadView(view: self)
    }
    
    @objc func cancel() {
        self.view.endEditing(true)
    }
    
    @IBAction func tomorrowSpaceButton(_ sender: Any) {
        dateUtils.tomorrowOrYesterdayFormatter(date: 1, repo: dateRepo)
        generalUtils.reloadView(view: self)
    }
    
    @IBAction func yesterdaySpaceButton(_ sender: Any) {
        dateUtils.tomorrowOrYesterdayFormatter(date: -1, repo: dateRepo)
        generalUtils.reloadView(view: self)
    }

}
