//
//  SecondViewController.swift
//  PhotoEditor
//
//  Created by User on 20/04/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!

    lazy var imageSize: CGSize = {
        return imageView.image!.size
    }()
    
    var rotationAngle: CGFloat = 0.0
    var flip: (CGFloat, CGFloat) = (1.0, 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setZoomScale()
        scrollView.zoomScale = scrollView.minimumZoomScale
    }
    
    @IBAction func rotateClockwise(_ sender: UIButton) {
        let newImage = imageRotatedByDegrees(oldImage: imageView.image!, deg: 90)
        let newImageView = UIImageView(image: newImage)
        newImageView.contentMode = .scaleAspectFill
        imageView.removeFromSuperview()
        scrollView.addSubview(newImageView)
        scrollView.setNeedsLayout()
    }
    
    @IBAction func rotateAnticlockwise(_ sender: UIButton) {
        rotationAngle -= 0.5
        transformImage()
    }
    
    @IBAction func flip(_ sender: UIButton) {
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func setZoomScale(){
        let imageSize = imageView.image!.size
        let smallestDimension = min(imageSize.width, imageSize.height)
        scrollView.minimumZoomScale = scrollView.bounds.width / smallestDimension
        scrollView.maximumZoomScale = smallestDimension / scrollView.bounds.width
    }
    
    func transformImage(){
        var transform = CGAffineTransform.identity
        transform = transform.rotated(by: .pi * rotationAngle)
        //transform = transform.scaledBy(x: flip.0, y: flip.1)
        imageView.transform = transform
        //scrollView.setNeedsLayout()
    }
    
    func imageRotatedByDegrees(oldImage: UIImage, deg degrees: CGFloat) -> UIImage {
        let size = oldImage.size
        
        UIGraphicsBeginImageContext(size)
        
        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        //Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: size.width / 2, y: size.height / 2)
        //Rotate the image context
        bitmap.rotate(by: (degrees * .pi / 180))
        //Now, draw the rotated/scaled image into the context
        bitmap.scaleBy(x: 1.0, y: -1.0)
        
        let origin = CGPoint(x: -size.width / 2, y: -size.height / 2)
        
        bitmap.draw(oldImage.cgImage!, in: CGRect(origin: origin, size: size))
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
