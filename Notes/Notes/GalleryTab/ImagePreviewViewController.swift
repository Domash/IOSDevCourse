//
//  ImagePreviewViewController.swift
//  Notes
//
//  Created by Денис Домашевич on 2/25/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import UIKit

class ImagePreviewViewController: UIViewController {
    
    var imagesArray: [UIImage] = []
    var imageViewsArray: [UIImageView] = []
    var selectedImageIndex: Int!

    
    @IBOutlet weak var mainScrollView: UIScrollView! {
        didSet {
            mainScrollView.isPagingEnabled = true
            mainScrollView.backgroundColor = UIColor.clear
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        
        for image in imagesArray {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageViewsArray.append(imageView)
        }

        let contentWidth = mainScrollView.frame.width * CGFloat(imageViewsArray.count)
        mainScrollView.contentSize = CGSize(width: contentWidth, height: mainScrollView.frame.height)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for (index, imageView) in imageViewsArray.enumerated() {
            imageView.frame.size = CGSize(width: mainScrollView.frame.width * 0.8, height: mainScrollView.frame.height * 0.6)
            let originX = (mainScrollView.frame.width) * CGFloat(index) + mainScrollView.frame.width * 0.1
            let originY = mainScrollView.frame.height * 0.2
            imageView.frame.origin.x = originX
            imageView.frame.origin.y = originY
            mainScrollView.addSubview(imageView)
            
            if index == selectedImageIndex {
                let selectedViewRect = CGRect(x: originX + mainScrollView.frame.width * 0.1, y: originY, width: mainScrollView.frame.width * 0.8, height: mainScrollView.frame.height * 0.6)
                mainScrollView.scrollRectToVisible(selectedViewRect, animated: false)
            }
        }
    }
    
}
