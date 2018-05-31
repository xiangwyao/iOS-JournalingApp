import UIKit
import RealmSwift

class JournalEntriesTableViewController: UITableViewController {
  
  @IBOutlet weak var topHeaderView: UIView!
  @IBOutlet weak var cameraButton: UIButton!
  @IBOutlet weak var plusButton: UIButton!
  var entries: Results<Entry>?
  
  func getEntries() {
    if let realm = try? Realm() {
      entries = realm.objects(Entry.self).sorted(byKeyPath: "date", ascending: false)
    }
    tableView.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    cameraButton.imageView?.contentMode = .scaleAspectFit
    plusButton.imageView?.contentMode = .scaleAspectFit
    topHeaderView.backgroundColor = UIColor(red: 0.298, green: 0.757, blue: 0.988, alpha: 1.00)
    navigationController?.navigationBar.barTintColor = UIColor(red: 0.298, green: 0.757, blue: 0.988, alpha: 1.00)
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    navigationController?.title = "Journal Lists"
  }
  
  override func viewWillAppear(_ animated: Bool) {
    getEntries()
  }
  
  @IBAction func cameraTapped(_ sender: UIButton) {
    performSegue(withIdentifier: "goToNew", sender: "camera")
    
  }
  @IBAction func plusTapped(_ sender: UIButton) {
    performSegue(withIdentifier: "goToNew", sender: "plus")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let entries = self.entries {
      return entries.count
    } else {
      return 0
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath) as? JournalCell {
      if let entry = entries?[indexPath.row] {
        cell.previewTextLabel.text = entry.text
        if let image = entry.pictures.first?.thumbnail() {
          cell.previewImageViewWidth.constant = 100.0
          cell.previewImageView.image = image
        } else {
          cell.previewImageViewWidth.constant = 0.0
        }
        
        cell.monthLabel.text = entry.monthString()
        cell.dayLabel.text = entry.dayString()
        cell.yearLabel.text = entry.yearString()
        
      }
      return cell
    }
    return UITableViewCell()
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let entry = entries?[indexPath.row] {
      performSegue(withIdentifier: "tableToDetail", sender: entry)
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100.0
  }
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToNew" {
      if let text = sender as? String {
        if text == "camera" {
          let dVC = segue.destination as? CreateJournalViewController
          dVC?.startWithCamera = true
        }
      }
    } else if segue.identifier == "tableToDetail" {
      if let entry = sender as? Entry {
        if let dVC = segue.destination as? JournalDetailViewController {
          dVC.entry = entry
        }
      }
    }
  }
  
}
