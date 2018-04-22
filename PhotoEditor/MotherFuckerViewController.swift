//
//  MotherFuckerViewController.swift
//  PhotoEditor
//
//  Created by User on 22/04/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit

class MotherFuckerViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var flipView: UIView!
    @IBOutlet weak var rotationView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var rotationAngle: CGFloat = 0
    var flip: (CGFloat, CGFloat) = (1, 1)
    var isFlipped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setZoomScale()
        scrollView.zoomScale = scrollView.minimumZoomScale
    }
    
    //MARK: User Actions
    
    @IBAction func rotateClockwise(_ sender: UIButton) {
        isFlipped == true ? (rotationAngle -= 0.5) : (rotationAngle += 0.5)
        resetRotationAngle()
        rotateImage(rotationAngle: rotationAngle)
    }
    
    @IBAction func rotateAnticlockwise(_ sender: UIButton) {
        isFlipped == true ? (rotationAngle += 0.5) : (rotationAngle -= 0.5)
        resetRotationAngle()
        rotateImage(rotationAngle: rotationAngle)
    }
    
    @IBAction func flip(_ sender: UIButton) {
        isFlipped == true ? (flip = (1, 1)) : (flip = (-1, 1))
        var transform = CGAffineTransform.identity
        transform = transform.scaledBy(x: flip.0, y: flip.1)
        flipView.transform = transform
        isFlipped = !isFlipped
    }
    
    //MARK: Scroll View Methods
    
    func setZoomScale(){
        let imageSize = imageView.image!.size
        let smallestDimension = min(imageSize.width, imageSize.height)
        scrollView.minimumZoomScale = scrollView.bounds.width / smallestDimension
        scrollView.maximumZoomScale = smallestDimension / scrollView.bounds.width
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    //MARK: Math
    
    func rotateImage(rotationAngle: CGFloat){
        var transform = CGAffineTransform.identity
        transform = transform.rotated(by: rotationAngle * .pi)
        rotationView.transform = transform
    }
    
    func resetRotationAngle(){
        if rotationAngle == 2 || rotationAngle == -2 {
            rotationAngle = 0
        }
        switch rotationAngle {
        case -0.5: rotationAngle = 1.5
        case -1: rotationAngle = 1
        case -1.5: rotationAngle = -0.5
        default: rotationAngle = 0
        }
        
    }
    
    func saveImage(){

    }
}


















