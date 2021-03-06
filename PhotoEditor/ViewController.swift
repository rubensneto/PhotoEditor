//
//  ViewController.swift
//  PhotoEditor
//
//  Created by User on 19/04/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    
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
        containerViewWidthConstraint.constant = imageSize.width
        containerViewHeightConstraint.constant = imageSize.height
    }
    
    @IBAction func rotateClockwise(_ sender: UIButton) {
        let size  = CGSize(width: imageView.bounds.height, height: imageView.bounds.width)
        let frame = CGRect(origin: CGPoint.zero, size: size)
        let newImageView = UIImageView(frame: frame)
        newImageView.translatesAutoresizingMaskIntoConstraints = false
        let newImage = imageRotatedByDegrees(oldImage: imageView.image!, deg: 90)
        newImageView.image = newImage
        newImageView.contentMode = .scaleAspectFill
        print(newImageView.bounds)
        imageView.removeFromSuperview()
        containerViewWidthConstraint.constant = size.width
        containerViewHeightConstraint.constant = size.height
        scrollView.frame = frame
        
        containerView.addSubview(newImageView)
        let visibleRect = CGRect(origin: CGPoint.zero, size: scrollView.bounds.size)
        scrollView.setNeedsDisplay(visibleRect)
    }
    
    
    
    @IBAction func rotateAnticlockwise(_ sender: UIButton) {
        rotationAngle -= 0.5
        transformImage()
    }
    
    @IBAction func flip(_ sender: UIButton) {
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return containerView
    }
    
    func setZoomScale(){
        let imageSize = imageView.image!.size
        let smallestDimension = min(imageSize.width, imageSize.height)
        scrollView.minimumZoomScale = scrollView.bounds.width / smallestDimension
        scrollView.maximumZoomScale = smallestDimension / scrollView.bounds.width
    }
    
    func transformImage(){
        let size = CGSize(width: containerView.bounds.height, height: containerView.bounds.size.width)
        let frame = CGRect(origin: CGPoint.zero, size: size)
        let zoomScale = scrollView.zoomScale
        scrollView.setZoomScale(1, animated: false)
        var transform = CGAffineTransform.identity
        transform = transform.rotated(by: .pi * rotationAngle)
        //transform = transform.scaledBy(x: flip.0, y: flip.1)
        imageView.transform = transform
        containerView.frame = frame
        containerView.setNeedsUpdateConstraints()
        scrollView.setNeedsLayout()
        scrollView.setZoomScale(zoomScale, animated: false)
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


