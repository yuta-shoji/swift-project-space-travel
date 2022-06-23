import UIKit

struct DateStruct {
    var fullDate, year, month, day: String
}

protocol Dates {
    func getDate() -> String
    func getYear() -> String
    func getMonth() -> String
    func getDay() -> String
    func change(date: String)
}

func getDays(num: Int) -> String {
    //structを初期化
    let dateUtils = DateUtils()
    //二日前の日付を取得
    let dt = Date(timeInterval: TimeInterval(60*60*24*num), since: Date())
    //yyyy-MM-ddの形にして返す
    return dateUtils.formatDate(date: dt)
}

//日付文字列をディクショナリーに変換
func makeDateObj(date: String) -> DateStruct {
    let startMonthIndex = date.index(date.startIndex, offsetBy: 5)
    let endMonthIndex = date.index(date.startIndex, offsetBy: 6)
    let startDayIndex = date.index(date.startIndex, offsetBy: 8)
    let endDayIndex = date.index(date.startIndex, offsetBy: 9)
    
    let result = DateStruct(
        fullDate: date,
        year: String(date.prefix(4)),
        month: String(date[startMonthIndex...endMonthIndex]),
        day: String(date[startDayIndex...endDayIndex])
    )
    
    return result
}

//　Repo
// CRUD
// Create, Remove, Update, Delete, Get
// InMemory, Database, API
final class InMemoryDateRepository: Dates {
    
    var dateObj = makeDateObj(date: getDays(num: -3))
    
    func getDate() -> String {
        return dateObj.fullDate
    }
   
    func getYear() -> String {
        return dateObj.year
    }
    
    func getMonth() -> String {
        return dateObj.month
    }
    
    func getDay() -> String {
        return dateObj.day
    }
   
    func change(date: String) {
        dateObj = makeDateObj(date: date)
    }
}
 
