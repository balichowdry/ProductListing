//
//  ProductTableViewCell.swift
//  Check24
//
//  Created by BilalSattar on 22/09/2018.
//  Copyright © 2018 BilalSattar. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var desc: UILabel!
}
