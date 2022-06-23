import UIKit
import RealmSwift
import SVProgressHUD

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var planet1TableView: UITableView!
    @IBOutlet weak var planet2TableView: UITableView!
    
    var planets1 = ["mercury", "venus", "earth", "mars", "jupiter", "saturn", "uranus", "neptune"]
    var planets2 = ["sun", "lunar", "blackhole", "galaxy", "milkyway", "comet", "andromeda", "satelite"]
    var tag: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        planet1TableView.dataSource = self
        planet1TableView.delegate = self
        planet2TableView.dataSource = self
        planet2TableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tag = tableView.tag
        print("tag : \(tag)")
        if tableView.tag == 0 {
            return planets1.count
        } else {
            return planets2.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tag = tableView.tag
        let cell: UITableViewCell
        if tableView.tag == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let imageView = cell.contentView.viewWithTag(1) as! UIImageView
            imageView.image = UIImage(named: planets1[indexPath.row])
            cell.textLabel!.text = planets1[indexPath.row]
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath)
            let imageView = cell.contentView.viewWithTag(2) as! UIImageView
            imageView.image = UIImage(named: planets2[indexPath.row])
            cell.textLabel!.text = planets2[indexPath.row]
        }
        cell.textLabel!.textColor = .white
        cell.textLabel!.font = UIFont(name:"Arial", size: 24)
        return cell
            
    }
    
    // prepareはsegue実行前に呼ばれるメソッド
    // オーバーライドすれば、値を渡す処理ができる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue" {
            if let indexPath = planet1TableView.indexPathForSelectedRow {
                guard let destination = segue.destination as? DetailViewController else {
                    fatalError("Failed to prepare DetailViewController!!!!!!!!")
                }
                destination.planet = planets1[indexPath.row]
            }
        } else {
            if let indexPath = planet2TableView.indexPathForSelectedRow {
                guard let destination = segue.destination as? DetailViewController else {
                    fatalError("Failed to prepare DetailViewController!!!!!!!!")
                }
                destination.planet = planets2[indexPath.row]
            }
        }
    }
    
    //SecondViewControllerが再度呼ばれるたびに実行
    override func viewWillAppear(_ animated: Bool) {
        //画面遷移前に選択されたいた行が、選択状態だった場合
        if let indexPath = planet1TableView.indexPathForSelectedRow{
            //選択状態を解除する
            planet1TableView.deselectRow(at: indexPath, animated: true)
        }
        if let indexPath = planet2TableView.indexPathForSelectedRow{
            //選択状態を解除する
            planet2TableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}
