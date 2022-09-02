//
//  FotoalbumViewController.swift
//  PraxisFreitag3
//
//  Created by Mirko Weitkowitz on 02.09.22.
//

import UIKit

class FotoalbumViewController: UIViewController {

    @IBOutlet weak var picViewTV: UICollectionView!
    
    private let reuseIdentifier = "viewpic"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        picViewTV.dataSource = self
        picViewTV.delegate = self
    }
    

    @IBAction func addpic(_ sender: UIBarButtonItem) {

        // MARK: UICollectionViewDataSource

         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // Methode kann alternativ entfallen
            return 1
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return countries.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
                as! GalleryImageCell

            let country = countries[indexPath.row]
    cell.imageView.image = country.image

            return cell
        }

    }
    }
    

}
