import UIKit
import RealmSwift
import SVProgressHUD

class DetailViewController: UIViewController {

    @IBOutlet weak var imgSliderView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //Realmをインスタンス化
    let travelData = TravelData()
    //Realmユーティリティインスタンス化(save, update, delete)
    let realmUtils = RealmUtils()
    //SecondViewControllerから 送られてくるデータを受け取る
    var planet: String!
    
    var travelImageArray: [TravelImageArrayStruct] = []
    var nowIndex = 0
    var timer: Timer!
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let newTimer = self.timer {
            newTimer.invalidate()
        }
        SVProgressHUD.dismiss()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        //選択された惑星のデータを取得する関数
        func searchPlanetData(url: String) {
            SVProgressHUD.show(withStatus: "Now Loading...")
            navigationItem.title = planet
            //urlオブジェクトを作成(型：URL)
            let url = URL(string: url)!
            //HTTPリクエストを作成
            let request = URLRequest(url: url)
            //デコーダーをインスタンス化
            let decoder: JSONDecoder = JSONDecoder()
                
            //URLSession.sharedで、URLに指定されたエンドポイントとのデータのやり取りができる
            let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
                guard let data = data else { return }

                do {
                    let nasa: PlanetStruct = try decoder.decode(PlanetStruct.self, from: data)
                    
                    //Realmに親要素を登録
                    travelData.travelDate = getDays(num: 1)
                    travelData.planet = self.planet
                    realmUtils.save(data: travelData)
                    
//                    let filteredRealm = realmUtils.filter(planet: self.planet)
//                    if realmUtils.filter(planet: self.planet) != 0 {
                        for item in nasa.collection.items.prefix(20) {
                            //mediaTypeのnil処理
                            if let definedDataFirst = item.data.first,
                               let definedMediaType = definedDataFirst.mediaType
                            {
                                //mediatypeがimageの場合のみ処理
                                if definedMediaType == "image" {
                                    //各種nil処理
                                    if let definedLinks = item.links,
                                        let definedLinksFirst = definedLinks.first,
                                        let definedDescription = definedDataFirst.datumDescription,
                                        let definedTitle = definedDataFirst.title
                                    {
                                        guard let imageUrl = URL(string: definedLinksFirst.href) else {
                                            print("Error : imageUrl is nil...")
                                            throw NSError(domain: "error", code: -1, userInfo: nil)
                                        }
                                        //URLからファイルの中身を取得する
                                        let data = try Data(contentsOf: imageUrl)
                                        let uiImage = UIImage(data: data)!
                                        //表示用の配列にimagePathを追加
                                        travelImageArray.append(
                                            TravelImageArrayStruct(
                                                planet: self.planet,
                                                date: definedDataFirst.dateCreated,
                                                title: definedTitle,
                                                description: definedDescription,
                                                imagePath: uiImage
                                            )
                                        )
                                        //Realmに子要素登録
                                        let travelInfo = TravelInfo()
                                        travelInfo.infoDate = definedDataFirst.dateCreated
                                        travelInfo.title = definedTitle
                                        travelInfo.descriptions = definedDescription
                                        travelInfo.imagePath = definedLinksFirst.href
                                        
                                        let realm = try! Realm()
                                        try! realm.write {
                                            travelData.infoArray.append(travelInfo)
                                        }
                                        
                                    } else {
                                        print("Error : APIs data is undefined.")
                                    }
                                }

                            } else {
                                print("Error : Media type is not image.")
                            }
                            DispatchQueue.main.async {
                                if self.travelImageArray.count == 1 {
                                    self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeItem), userInfo: nil, repeats: true)
                                }
                            }
                        }
                        
                        print("############ array ############")
                        print(travelImageArray)
//                    }
                } catch let e {
                    print("JSON Decode Error :\(e)")
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.imgSliderView.image = UIImage(named: "noImage")
                    }
                }
            }

            
            task.resume()

        }
        print("=====planet================ : https://images-api.nasa.gov/search?q=\(planet!)")
        searchPlanetData(url: "https://images-api.nasa.gov/search?q=\(planet!)")

    }
    
    @objc func changeItem() {
        SVProgressHUD.dismiss()
        nowIndex += 1
        
        print("nowIndex : \(nowIndex)")

        if (nowIndex == travelImageArray.count) {
            nowIndex = 0
        }
        print("index!!! :  \(travelImageArray[nowIndex])")
        imgSliderView.image = travelImageArray[nowIndex].imagePath
        titleLabel.text = travelImageArray[nowIndex].title
        descriptionTextView.text = travelImageArray[nowIndex].description
    }

}
