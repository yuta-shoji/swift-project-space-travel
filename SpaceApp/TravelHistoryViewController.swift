import UIKit
import RealmSwift
import SVProgressHUD

class TravelHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var travelHistoryTableView: UITableView!
    //Realmインスタンス化
    let realm = try! Realm()
    //Realmユーティリティインスタンス化(save, update, delete)
    let realmUtils = RealmUtils()

    var result: Results<TravelData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //全件取得
        result = realm.objects(TravelData.self)
//        guard result != nil else { return }
        
        print(type(of: result))
        
//        for data in result {
//            print(data.planet)
//            print(data.travelDate)
//        }
        
        travelHistoryTableView.dataSource = self
        travelHistoryTableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(TravelData.self).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TravelHistoryCell", for: indexPath)
        let imageView = cell.contentView.viewWithTag(3) as! UIImageView
        cell.textLabel!.textColor = .white
        cell.textLabel!.font = UIFont(name:"Arial", size: 20)
        imageView.image = UIImage(named: result[indexPath.row].planet)
        cell.textLabel!.text = result[indexPath.row].travelDate + "  " + result[indexPath.row].planet + "  [" + String(result[indexPath.row].infoArray.count) + " Photos]"
        return cell
            
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = travelHistoryTableView.indexPathForSelectedRow {
            guard let destination = segue.destination as? DetailViewController else {
                fatalError("Failed to prepare travelHistoryViewController")
            }
            destination.planet = result[indexPath.row].planet
        }
    }
    
    //SecondViewControllerが再度呼ばれるたびに実行
    override func viewWillAppear(_ animated: Bool) {
        //画面遷移前に選択されたいた行が、選択状態だった場合
        if let indexPath = travelHistoryTableView.indexPathForSelectedRow{
            //選択状態を解除する
            travelHistoryTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}
