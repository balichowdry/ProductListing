//
//  ProductDetailViewController.swift
//  Check24
//
//  Created by BilalSattar on 22/09/2018.
//  Copyright © 2018 BilalSattar. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBAction func openWebView(_ sender: Any) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Check24WebViewController") as? Check24WebViewController {
            self.present(viewController, animated:true, completion:nil)
        }
    }
    @IBAction func favButton(_ sender: Any) {
        
    }
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var productDetailImageView: UIImageView!
    @IBOutlet weak var productDetailName: UILabel!
    @IBOutlet weak var shortDesc: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var longDesc: UILabel!
    
    var productName = "", productImageUrl = "", productDate = "", productshortDesc = "", productPrice = "", productLongDesc: String = ""
    var productRating: Double = 0.0
    
    var productDetail = [ProductListing]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productDetailName.text = productName
        self.date.text = self.productDate
        self.shortDesc.text = productshortDesc
        self.longDesc.text = productLongDesc
        self.price.text = productPrice
        self.rating.rating = productRating
        let url = URL(string: productImageUrl )

        self.productDetailImageView!.sd_setImage(with: url, completed: nil)
        
    }
}


