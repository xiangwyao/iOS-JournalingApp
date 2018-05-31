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
    // Dispose of any resources that can be recreated.
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using [segue destinationViewController].
   // Pass the selected object to the new view controller.
   }
   */
  
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
    }
    
    
    
    // Configure the cell
    
    return UICollectionViewCell()
  }
  
  
  
}
