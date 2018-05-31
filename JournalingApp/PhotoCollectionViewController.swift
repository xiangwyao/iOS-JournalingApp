import UIKit
import RealmSwift

class PhotoCollectionViewController: UICollectionViewController {

  var pictures: Results<Picture>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    getPictures()
  }
  
  func getPictures() {
    if let realm = try? Realm() {
      pictures = realm.objects(Picture.self)
      collectionView?.reloadData()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let picutres = self.pictures {
      return picutres.count
    }
    return 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell {
      if let picture = pictures?[indexPath.row] {
        cell.previewImageView.image = picture.thumbnail()
        cell.dayLabel.text = picture.entry?.dayString()
        cell.monthYearLabel.text = picture.entry?.monthYearString()
      }
      return cell
    }
    return UICollectionViewCell()
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    performSegue(withIdentifier: "photoToDetail", sender: pictures?[indexPath.row].entry)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "photoToDetail" {
      if let entry = sender as? Entry {
        if let dVC = segue.destination as? JournalDetailViewController {
          dVC.entry = entry
        }
      }
    }
  }
  
}
