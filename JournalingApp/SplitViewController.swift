//
//  SplitViewController.swift
//  JournalingApp
//
//  Created by learn on 5/29/18.
//  Copyright © 2018 Wenyao. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController, UISplitViewControllerDelegate {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.delegate = self
    self.preferredDisplayMode = .allVisible
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
    return true
  }
  
}
