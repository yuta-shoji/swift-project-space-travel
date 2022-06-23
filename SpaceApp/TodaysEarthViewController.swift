import UIKit
import SVProgressHUD

class TodaysEarthViewController: UIViewController {
    
    @IBOutlet weak var apiImage: UIImageView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sunPositionXLabel: UILabel!
    @IBOutlet weak var sunPositionYLabel: UILabel!
    @IBOutlet weak var sunPositionZLabel: UILabel!
    @IBOutlet weak var lunarPositionXLabel: UILabel!
    @IBOutlet weak var lunarPositionYLabel: UILabel!
    @IBOutlet weak var lunarPositionZLabel: UILabel!
    
    private let dateRepo = InMemoryDateRepository()
    var datePicker: UIDatePicker = UIDatePicker()
    var alert: UIAlertController!
    let generalUtils = GeneralUtils()
    let dateUtils = DateUtils()
    var earthImageArray: [EarthImageArrayStruct] = []
    var nowIndex = 0
    var myTimer: Timer?
    var timerStopFlg: Bool = false

    //インスタンスの各種設定
    func settingInstance() {
        dateTextField.text = dateRepo.getDate()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let timer = self.myTimer {
            timer.invalidate()
        }
        SVProgressHUD.dismiss()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingInstance()
        alert = TodayClass.nonExistAlert()
        
        //今日の宇宙データを取得する関数
        func searchTodaysSpaceData(query: String, url: String) {
            SVProgressHUD.show(withStatus: "Now Loading...")
            //urlオブジェクトを作成(型：URL)
            let url = URL(string: url + query)!
            //HTTPリクエストを作成
            let request = URLRequest(url: url)
            //デコーダーをインスタンス化
            let decoder: JSONDecoder = JSONDecoder()
                
            //URLSession.sharedで、URLに指定されたエンドポイントとのデータのやり取りができる
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let nasa: TodaysEarthOuterStruct = try decoder.decode(TodaysEarthOuterStruct.self, from: data)
                    for earth in nasa {
                        let imageUrlString = "https://api.nasa.gov/EPIC/archive/natural/\(self.dateRepo.getYear())/\(self.dateRepo.getMonth())/\(self.dateRepo.getDay())/png/\(earth.image).png?api_key=oKsAwOzVHXn306L3kwemIf38VgyBEcbgL6QVDl9u"
                        let imageUrl = URL(string: imageUrlString)
                        //URLからファイルの中身を取得する
                        let data = try Data(contentsOf: imageUrl!)
                        let uiImage = UIImage(data: data)!
                        self.earthImageArray.append(
                            EarthImageArrayStruct(
                                time: String(earth.date.suffix(8)),
                                imagePath: uiImage,
                                lat: earth.centroidCoordinates.lat,
                                lon: earth.centroidCoordinates.lon,
                                sunPositionX: earth.sunJ2000Position.x,
                                sunPositionY: earth.sunJ2000Position.y,
                                sunPositionZ: earth.sunJ2000Position.z,
                                lunarPositionX: earth.lunarJ2000Position.x,
                                lunarPositionY: earth.lunarJ2000Position.y,
                                lunarPositionZ: earth.lunarJ2000Position.z
                            )
                        )
                        SVProgressHUD.dismiss()
                        DispatchQueue.main.async {
                            if self.earthImageArray.count == 1 {
                                self.myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeItem), userInfo: nil, repeats: true)
                            }
                        }
                    }
                } catch {
                    print("JSON Decode Error")
                    //アラートコントローラーを表示
                    DispatchQueue.main.async {
                        self.apiImage.image = UIImage(named: "noImage")
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

        searchTodaysSpaceData(query: "", url: "https://api.nasa.gov/EPIC/api/natural/date/\(dateRepo.getDate())?api_key=oKsAwOzVHXn306L3kwemIf38VgyBEcbgL6QVDl9u")
    }
    
    @objc private func changeItem() {
        nowIndex += 1
        if (nowIndex == earthImageArray.count) {
            nowIndex = 0
        }
        let earthObj = earthImageArray[nowIndex]
        timeLabel.text = String(earthObj.time.suffix(8))
        apiImage.image = earthObj.imagePath
        latLabel.text = String(earthObj.lat)
        lonLabel.text = String(earthObj.lon)
        sunPositionXLabel.text = String(earthObj.sunPositionX)
        sunPositionYLabel.text = String(earthObj.sunPositionY)
        sunPositionZLabel.text = String(earthObj.sunPositionZ)
        lunarPositionXLabel.text = String(earthObj.lunarPositionX)
        lunarPositionYLabel.text = String(earthObj.lunarPositionY)
        lunarPositionZLabel.text = String(earthObj.lunarPositionZ)
        
    }
}
