//
//  GalleryCollectionViewController.swift
//  Notes
//
//  Created by Денис Домашевич on 2/25/20.
//  Copyright © 2020 Денис Домашевич. All rights reserved.
//

import UIKit

class GalleryCollectionViewController: UIViewController {
    
    var imageNames: [String] = [
        "gradient_image",
        "gradient_image",
        "gradient_image",
        "gradient_image",
        "gradient_image",
        "gradient_image",
        "gradient_image",
        "gradient_image",
        "gradient_image",
        "gradient_image",
        "gradient_image",
        "gradient_image"
    ]
    
    var imagesArray: [UIImage] = []
    
    var galleryCollectionFlowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var galleryCollectionView: UICollectionView! {
        didSet {
            galleryCollectionView.delegate = self
            galleryCollectionView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGalleryCollectionView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupGalleryCollectionViewItemSize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGalleryPreview" {
            guard let indexPath = sender as? IndexPath else {return}
            guard let nextVC = segue.destination as? ImagePreviewViewController else {return}
            nextVC.imagesArray = imagesArray
            nextVC.selectedImageIndex = indexPath.row
        }
    }
    
    private func setupGalleryCollectionView() {
        let nib = UINib(nibName: "GalleryCollectionViewCell", bundle: nil)
        galleryCollectionView.register(nib, forCellWithReuseIdentifier: "galleryCell")
    }
    
    private func setupGalleryCollectionViewItemSize() {
        if galleryCollectionFlowLayout == nil {
        
            let width = (galleryCollectionView.bounds.size.width - 40) / 5
            let height = width
        
            galleryCollectionFlowLayout = UICollectionViewFlowLayout()
            galleryCollectionFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            galleryCollectionFlowLayout.itemSize = CGSize(width: width, height: height)
            galleryCollectionView.setCollectionViewLayout(galleryCollectionFlowLayout, animated: true)
            
        }
    }
    
}

extension GalleryCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! GalleryCollectionViewCell
        
        guard let currentImage = UIImage(named: imageNames[indexPath.row])
            else {
                cell.backgroundColor = .gray
                return cell
        }
        imagesArray.append(currentImage)
        cell.imageView.image = currentImage
        
        cell.imageView.image = currentImage
        
        return cell
        
    }
}

extension GalleryCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showGalleryPreview", sender: indexPath)
    }
}
