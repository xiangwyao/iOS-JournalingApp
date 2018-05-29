import UIKit
import RealmSwift
import Toucan

class Picture: Object { // thumbnail and full image
  @objc dynamic var fullImageName = ""
  @objc dynamic var thumbnailName = ""
  @objc dynamic var entry: Entry?
  
  convenience init(image: UIImage) {
    self.init()
    fullImageName = imageToURIString(image: image)
    if let smallImage = Toucan(image: image).resize(CGSize(width: 500, height: 500), fitMode: .crop).image {
      thumbnailName = imageToURIString(image: smallImage)
    }
  }
  
  func imageToURIString(image: UIImage) -> String {
    if let imageData =
      UIImageJPEGRepresentation(image, CGFloat(IMAGE_QUALITY)) {
      let fileName = UUID().uuidString + ".jpg"
      var path =
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      path.appendPathComponent(fileName)
      try? imageData.write(to: path)
      return fileName
    }
    return ""
  }
  
  func fullImage() -> UIImage {
    return imageWithFileName(fileName: fullImageName)
  }
  
  func thumbnail() -> UIImage {
    return imageWithFileName(fileName: thumbnailName)
  }
  
  func imageWithFileName(fileName: String) -> UIImage {
    var path =
      FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    path.appendPathComponent(fileName)
    if let imageData = try? Data(contentsOf: path) {
      if let image = UIImage(data: imageData) {
        return image
      }
    }
    return UIImage()
  }
  
}
