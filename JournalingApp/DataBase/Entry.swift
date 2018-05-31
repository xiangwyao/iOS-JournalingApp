import UIKit
import RealmSwift
import Toucan

let IMAGE_QUALITY = 1.0

class Entry: Object {
  @objc dynamic var text = ""
  @objc dynamic var date = Date()
  let pictures = List<Picture>()
  
  func splitDate() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "E, MMM d, yyyy"
    return formatter.string(from: date)
  }
  
  func monthString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM"
    return formatter.string(from: date)
  }
  
  func dayString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "d"
    return formatter.string(from: date)
  }
  
  func yearString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return formatter.string(from: date)
  }
  
  func monthYearString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM, yyyy"
    return formatter.string(from: date)
  }
  
}


