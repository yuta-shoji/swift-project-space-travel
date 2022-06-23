import UIKit
import Foundation
import RealmSwift

class TravelData: Object {
    @objc dynamic var travelDate: String = ""
    @objc dynamic var planet: String = ""
    let infoArray = List<TravelInfo>()
}

class TravelInfo: Object {
    @objc dynamic var infoDate: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var descriptions: String = ""
    @objc dynamic var imagePath: String = ""
}


//func getAllDatum() -> [DatumStruct]{
//    var list: [DatumStruct] = []
//
//    let results = Realm.object()
//    for item in results {
//        let datum = DatumStruct(item.center, ....)
//        list.append(datum)
//    }
//
//    return list
//}



class RealmUtils {
    
    //全データ取得
    func getAll() {
        do {
            let realm = try Realm()
            let results = realm.objects(TravelData.self)
            print(results)
            print(type(of: results))
        } catch let e {
            print("Realm getAll Error :\(e)")
        }
    }
    
    //データ保存
    func save(data: Object) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(data)
            }
        } catch let e {
            print("Realm save Error :\(e)")
        }
    }
    
    // データ更新
    func update(column: String, newData: String) {
      do {
          let realm = try! Realm()
          let data = realm.objects(TravelData.self).last!
          try realm.write {
          data[column] = newData
        }
      } catch let e {
          print("Realm update Error :\(e)")
      }
    }
    
    // データ削除
    func delete() {
      do {
        let realm = try! Realm()
        let data = realm.objects(TravelData.self).last!
        try realm.write {
          realm.delete(data)
        }
      } catch let e {
          print("Realm delete Error :\(e)")
      }
    }
    
    // 全データ削除
    func deleteAll() {
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]
        for URL in realmURLs {
            do {
                try FileManager.default.removeItem(at: URL)
            } catch {
                return
            }
        }
        print("Finshed delete all data")
    }
    
    // データ抽出
    func filter(planet: String) -> Int {
        do {
            let realm: Realm = try Realm()
            let data = realm.objects(TravelData.self).filter("planet==" + planet)
            print("data !!!!!!!!!!!!!!!!!!!! : \(type(of: data))")
            return data.count
        } catch {
            print("Realm filter Error")
            return 0
        }
    }
}
