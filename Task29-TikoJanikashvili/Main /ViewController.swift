//
//  ViewController.swift
//  Task29-TikoJanikashvili
//
//  Created by Tiko on 09.06.21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var panLabel: UILabel!
    @IBOutlet weak var longPressLabel: UILabel!
    @IBOutlet weak var swipelabel: UILabel!
    @IBOutlet weak var pinchLabel: UILabel!
    
    // MARK: - Private Properties
    private var state = State.panGesture.rawValue
    
    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.swipelabel.isUserInteractionEnabled = true
        self.configurePanGesture()
        self.configurePinchGesture()
        self.configureSwipeRightGesture()
        self.configureSwipeUpGesture()
        self.configureSwipeDownGesture()
        self.configureSwipeLeftGesture()
        self.configurelongPressGesture()
    }
    
    private func configurePanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handelPan(_:)))
        self.panLabel.isUserInteractionEnabled = true
        self.panLabel.addGestureRecognizer(panGesture)
    }
    
    private func configurelongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handelLongPress(_:)))
        longPressGesture.minimumPressDuration = 1
        self.longPressLabel.isUserInteractionEnabled = true
        self.longPressLabel.addGestureRecognizer(longPressGesture)
    }
    
    private func configureSwipeLeftGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handelSwipe(_:)))
        swipeGesture.direction = .left
        self.swipelabel.addGestureRecognizer(swipeGesture)
    }
    
    private func configureSwipeRightGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handelSwipe(_:)))
        swipeGesture.direction = .right
        self.swipelabel.addGestureRecognizer(swipeGesture)
    }
    
    private func configureSwipeUpGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handelSwipe(_:)))
        swipeGesture.direction = .up
        self.swipelabel.addGestureRecognizer(swipeGesture)
    }
    
    private func configureSwipeDownGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handelSwipe(_:)))
        swipeGesture.direction = .down
        self.swipelabel.addGestureRecognizer(swipeGesture)
    }
    
    private func configurePinchGesture() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handelPinch(_:)))
        self.pinchLabel.isUserInteractionEnabled = true
        self.pinchLabel.addGestureRecognizer(pinchGesture)
        
    }
    
    private func goToScreen(state: State, point: CGPoint = CGPoint(x: 0, y: 0)) {
        let sb = UIStoryboard(name: "DetailViewController", bundle: nil)
        if let vc = sb.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ViewController {
    @objc private func handelPan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        print(translation.x)
        
        switch gesture.state {
        case .began:
            print("Began")
        case .changed:
            self.panLabel.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
            self.panLabel.text = "\(translation.x - translation.y)"
        case .ended:
            self.panLabel.transform = .identity
            self.panLabel.text = "UIPanGestureRecognizer"
            self.goToScreen(state: .panGesture)
        default:
            break
        }
    }
    
    @objc private func handelLongPress(_ gesture: UILongPressGestureRecognizer) {
        self.goToScreen(state: .pressGesture)
    }
    
    @objc private func handelSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            print("left")
            swipelabel.transform = CGAffineTransform(translationX: -50, y: 0)
        case .right:
            print("right")
            swipelabel.transform = CGAffineTransform(translationX: 50, y: 0)
        case .up:
            print("up")
            swipelabel.transform = CGAffineTransform(translationX: 0, y: -50)
        case .down:
            print("down")
            swipelabel.transform = CGAffineTransform(translationX: 0, y: 50)
        default:
            print("Dont match")
        }
    }
    
    @objc private func handelPinch(_ gesture: UIPinchGestureRecognizer) {
        if let view = gesture.view {
            switch gesture.state {
            case .changed:
                let pinchCenter = CGPoint(x: gesture.location(in: view).x - view.bounds.midX,
                                          y: gesture.location(in: view).y - view.bounds.midY)
                print(self.view.transform)
                let transform = view.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y).scaledBy(x: gesture.scale, y: gesture.scale).translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
                view.transform = transform
                gesture.scale = 1
            case .ended:
                UIView.animate(withDuration: 0.2, animations: {
                    view.transform = CGAffineTransform.identity
                })
            default:
                break
            }
        }
    }
}

