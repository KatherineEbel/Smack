//
//  AvatarPickerController.swift
//  Smack
//
//  Created by Katherine Ebel on 11/16/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import UIKit

class AvatarPickerController: UIViewController {

  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var segmentedControl: UISegmentedControl!
  
  var avatarType: AvatarType = .dark {
    didSet {
      guard let collectionView = collectionView else { return }
      collectionView.reloadData()
    }
  }
  
  var avatar: Avatar?

  override func viewDidLoad() {
      super.viewDidLoad()
  }

  @IBAction func backButtonTapped() {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
    avatarType = sender.selectedSegmentIndex == 0 ? .dark : .light
  }
}

extension AvatarPickerController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let avatarCell = collectionView.cellForItem(at: indexPath) as? AvatarCell, let avatar = avatarCell.avatar else { return }
    
    if let createAccountVC = presentingViewController as? CreateAccountViewController {
      createAccountVC.avatar = avatar
    }
    dismiss(animated: true)
  }
}

extension AvatarPickerController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 28
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.avatarCell.rawValue, for: indexPath) as? AvatarCell else { return AvatarCell() }
    let cellAvatar = Avatar(id: indexPath.row, type: avatarType, color: avatar!.color)
    cell.avatar = cellAvatar
    return cell
  }
  
  
}
extension AvatarPickerController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    var numCols: CGFloat = 3
    if UIScreen.main.bounds.width > 320 {
      numCols = 4
    }
    let space: CGFloat = 10
    let padding: CGFloat = 40
    let cellDimension = ((collectionView.bounds.width - padding) - (numCols - 1) * space) / numCols
    return CGSize(width: cellDimension, height: cellDimension)
  }
}
