import UIKit

struct DateUtils {
    //formatterインスタンス化
    func makeFormatter() -> DateFormatter {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss Z"
        return formatter
    }
    
    //文字列を日付に変換
    func dateFromString(string: String) -> Date {
        return makeFormatter().date(from: string)!
    }
    
    //日付を文字列に変換
    func stringFromDate(date: Date) -> String {
        return makeFormatter().string(from: date)
    }
    
    //日付をyyyy-MM-dd形式に変換
    func formatDate(date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd", options: 0, locale: Locale(identifier: "ja_JP"))
        let before = formatter.string(from: date)
        return before.replacingOccurrences(of: "/", with: "-")
    }
    
    //日付を明日or昨日に更新
    func tomorrowOrYesterdayFormatter(date: Int, repo: Dates) -> Void {
        //今の日付を取得
        let nowStr = repo.getDate().replacingOccurrences(of: "-", with: "/")
        //日付型に変換
        let nowDate = self.dateFromString(string: "\(nowStr) 00:00:01 +09:00")
        //翌日の日付を取得
        let tomorrowDate = Date(timeInterval: TimeInterval(60 * 60 * 24 * date), since: nowDate)
        //yyyy-MM-dd形式の文字列に変換
        let tomorrowStr = self.formatDate(date: tomorrowDate)
        //日付を更新
        repo.change(date: tomorrowStr)
        print(repo.getDate())
    }
    
}
