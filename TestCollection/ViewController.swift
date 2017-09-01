//
//  ViewController.swift
//  TestCollection
//
//  Created by Admin on 01/09/2017.
//  Copyright © 2017 1C Rarus. All rights reserved.
//

import UIKit

var cells: [CGSize] = []

func printTest(_ string: String) {
    print("Test_Collection: \(string)")
}

class ViewController: UIViewController {

    private var keyboardTracker: KeyboardTracker!

    var inputBarBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var chatInputView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInputView()
        configureBackgroundTap()
        
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        keyboardTracker.startTracking()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        keyboardTracker.stopTracking()
    }
    
    

    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        keyboardTracker.adjustTrackingViewSizeIfNeeded()
    }

    func configureBackgroundTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnBackground))
        view.addGestureRecognizer(tap)
        
    }

    func tapOnBackground(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        let height = arc4random_uniform(30) + 20
        let width = arc4random_uniform(50) + 100
        
        cells.append(CGSize(width: CGFloat(width), height: CGFloat(height)))
        printTest("cell added")
        collectionView.reloadData()
    }
    
    
    func configureInputView() {
        
        
        let inputContainer = UIView(frame: CGRect.zero)
        inputContainer.autoresizingMask = UIViewAutoresizing()
        inputContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputContainer)
        view.addConstraint(NSLayoutConstraint(item: inputContainer, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: inputContainer, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: inputContainer, attribute: .trailing, multiplier: 1, constant: 0))
        inputBarBottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: inputContainer, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(inputBarBottomConstraint)
        
        inputContainer.addSubview(chatInputView)
        inputContainer.addConstraint(NSLayoutConstraint(item: inputContainer, attribute: .top, relatedBy: .equal, toItem: chatInputView, attribute: .top, multiplier: 1, constant: 0))
        inputContainer.addConstraint(NSLayoutConstraint(item: inputContainer, attribute: .leading, relatedBy: .equal, toItem: chatInputView, attribute: .leading, multiplier: 1, constant: 0))
        inputContainer.addConstraint(NSLayoutConstraint(item: inputContainer, attribute: .bottom, relatedBy: .equal, toItem: chatInputView, attribute: .bottom, multiplier: 1, constant: 0))
        inputContainer.addConstraint(NSLayoutConstraint(item: inputContainer, attribute: .trailing, relatedBy: .equal, toItem: chatInputView, attribute: .trailing, multiplier: 1, constant: 0))
        
        view.addSubview(inputContainer)
        
        let layoutBlock = { [weak self] (bottomMargin: CGFloat) in
            guard let sSelf = self else { return }
            
            let newConstant = max(bottomMargin, sSelf.bottomLayoutGuide.length)
            sSelf.inputBarBottomConstraint.constant = newConstant
            
            sSelf.view.layoutIfNeeded()
        }
        
        keyboardTracker = KeyboardTracker(viewController: self, inputContainer: inputContainer, layoutBlock: layoutBlock, notificationCenter: NotificationCenter.default)
        (self.view as! ChatControllerView).bmaInputAccessoryView = keyboardTracker.trackingView
        
    }


}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        
        cell.view.backgroundColor = UIColor.brown
        
        return cell
    }
    
}
