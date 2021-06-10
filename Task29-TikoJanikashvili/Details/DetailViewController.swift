//
//  DetailViewController.swift
//  Task29-TikoJanikashvili
//
//  Created by Tiko on 09.06.21.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var imageFlower: UIImageView!
    
    // MARK: - Private Properties
    private var state = State.panGesture
    private var point: CGPoint = CGPoint(x: 0, y: 0)
    
    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.configurelongPressGesture()
    }
    
    private func configurelongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handelLongPress(_:)))
        longPressGesture.minimumPressDuration = 2
        self.imageFlower.isUserInteractionEnabled = true
        self.imageFlower.addGestureRecognizer(longPressGesture)
    }
    
    private func setup() {
        switch self.state {
        case .panGesture:
            print("DetailView")
        case .pressGesture:
            if state.rawValue < 1 {
                self.navigationController?.popViewController(animated: true)
            }
        default:
            break
        }
    }
}

extension DetailViewController {
    @objc private func handelLongPress(_ gesture: UILongPressGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
        print(#function)
    }
}
