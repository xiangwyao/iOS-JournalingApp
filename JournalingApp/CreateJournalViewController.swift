import UIKit
import RealmSwift

class CreateJournalViewController: UIViewController {
  
  @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var journalTextView: UITextView!
  @IBOutlet weak var navBar: UINavigationBar!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var setDateButton: UIButton!
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var aboveNavBarView: UIView!
  
  var date = Date()
  var imagePicker = UIImagePickerController()
  var images: [UIImage] = []
  var startWithCamera = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navBar.barTintColor = UIColor(red: 0.298, green: 0.757, blue: 0.988, alpha: 1.00) // #4cc1fc
    navBar.tintColor = .white
    navBar.isTranslucent = false
    navBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    aboveNavBarView.backgroundColor = UIColor(red: 0.298, green: 0.757, blue: 0.988, alpha: 1.00) // #4cc1fc
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
    
    imagePicker.delegate = self
  }
  
  @objc func keyboardWillHide(notification: Notification) {
    changeKeyboardHeight(notification)
  }
  
  @objc func keyboardWillShow(notification: Notification) {
    changeKeyboardHeight(notification)
  }
  
  func changeKeyboardHeight(_ notification: Notification) {
    if let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
      let keyHeight = keyboardFrame.cgRectValue.height
      bottomConstraint.constant = keyHeight + 10
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    updateDate()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    if startWithCamera {
      startWithCamera = false
      cameraTapped("")
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func cancelTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  @IBAction func saveTapped(_ sender: Any) {
    updateDate()
    if let realm = try? Realm() {
      let entry = Entry()
      entry.text = journalTextView.text
      entry.date = date
      for image in images {
        let picture = Picture(image: image)
        entry.pictures.append(picture)
        picture.entry = entry
      }
      
      try? realm.write {
        realm.add(entry)
      }
      
      dismiss(animated: true, completion: nil)
    }
  }
  @IBAction func saveDateTapped(_ sender: Any) {
    journalTextView.isHidden = false
    datePicker.isHidden = true
    setDateButton.isHidden = true
    updateDate()
  }
  
  @IBAction func calendarTapped(_ sender: Any) {
    journalTextView.isHidden = true
    datePicker.isHidden = false
    setDateButton.isHidden = false
    datePicker.date = date
  }
  @IBAction func cameraTapped(_ sender: Any) {
    imagePicker.sourceType = .photoLibrary
    present(imagePicker, animated: true, completion: nil)
//    NotificationCenter.value(forKey: String)
  }
  
  func updateDate() {
    let formatter = DateFormatter()
    formatter.dateFormat = "E, MMM d, yyyy"
    date = datePicker.date
    navBar.topItem?.title = formatter.string(from: date)
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

// MARK: - UIImagePickerDelegation Stuff
extension CreateJournalViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      images.append(chosenImage)
      let imageView = UIImageView()
      imageView.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
      imageView.widthAnchor.constraint(equalToConstant: 70.0).isActive = true
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      imageView.image = chosenImage
      stackView.addArrangedSubview(imageView)
      imagePicker.dismiss(animated: true) {
        // animation
      }
    }
  }
  
}
