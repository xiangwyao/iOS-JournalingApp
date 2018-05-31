import UIKit
import RealmSwift


class JournalCell: UITableViewCell {
  @IBOutlet weak var previewImageView: UIImageView!
  @IBOutlet weak var previewTextLabel: UILabel!
  @IBOutlet weak var monthLabel: UILabel!
  @IBOutlet weak var dayLabel: UILabel!
  @IBOutlet weak var yearLabel: UILabel!
  
  @IBOutlet weak var previewImageViewWidth: NSLayoutConstraint!
}
