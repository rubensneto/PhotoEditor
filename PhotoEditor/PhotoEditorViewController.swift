//
//  PhotoEditorViewController.swift
//  PhotoEditor
//
//  Created by User on 22/04/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit

class PhotoEditorViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var flipView: UIView!
    @IBOutlet weak var ratationView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let minimumScale: CGFloat = 1
    lazy var maximumScale: CGFloat = {
        let smallerSize = min(imageView.image!.size.width, imageView.image!.size.width)
        return smallerSize / 250
    }()
    
    var rotationAngle: CGFloat = 0
    var flip: (CGFloat, CGFloat) = (1.0, 1.0)
    var scale: CGFloat = 1
    var isFlipped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    @IBAction func rotateClocwise(_ sender: UIButton) {
        rotationAngle += 0.5
        var transform = CGAffineTransform.identity
        transform = transform.rotated(by: .pi * rotationAngle)
        ratationView.transform = transform
    }
    
    @IBAction func rotateAnticlockwise(_ sender: UIButton) {
        rotationAngle -= 0.5
        var transform = CGAffineTransform.identity
        transform = transform.rotated(by: .pi * rotationAngle)
        ratationView.transform = transform
    }
    
    @IBAction func flip(_ sender: UIButton) {
        isFlipped == true ? (flip = (1, 1)) : (flip = (-1, 1))
        var transform = CGAffineTransform.identity
        transform = transform.scaledBy(x: flip.0, y: flip.1)
        flipView.transform = transform
        isFlipped = !isFlipped
    }
    
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
//        let translation = recognizer.translation(in: self.view)
//        if let view = recognizer.view {
//            view.center = CGPoint(x:view.center.x + translation.x,
//                                  y:view.center.y + translation.y)
//        }
//        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @IBAction func handlePinch(recognizer: UIPinchGestureRecognizer){
//        if let view = recognizer.view {
//            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
//            scale = recognizer.scale
//            recognizer.scale = 1
//        }
    }
    
    


}
