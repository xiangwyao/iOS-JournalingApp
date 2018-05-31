import UIKit

class JournalDetailViewController: UIViewController {

  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var journalTextLabel: UILabel!
  
  var entry: Entry?
  
  override func viewDidLoad() {
        super.viewDidLoad()

    if let entry = self.entry {
      title = entry.dayString()
      journalTextLabel.text = entry.text
      for picture in entry.pictures {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        let ratio = picture.fullImage().size.height / picture.fullImage().size.width
        imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1.0)
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: ratio).isActive = true
        imageView.image = picture.fullImage()
        stackView.addArrangedSubview(imageView)
      }
    } else {
      journalTextLabel.text = ""
    }
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
