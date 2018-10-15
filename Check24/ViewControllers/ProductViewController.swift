//
//  ViewController.swift
//  Check24
//
//  Created by BilalSattar on 22/09/2018.
//  Copyright © 2018 BilalSattar. All rights reserved.
//

import UIKit
import SDWebImage
import WebKit

class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet var webView: WKWebView!
    var refreshControl = UIRefreshControl()
    // Image cache
    var thumbnailImages: [Int: UIImage] = [:]

    @IBOutlet weak var productTableView: UITableView!
    var productList = [ProductListing]()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.parseJSON()
        // Do any additional setup after loading the view, typically from a nib.
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(parseJSON), for: UIControl.Event.valueChanged)
        productTableView.addSubview(refreshControl)
    }
    
    //MARK: TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if productList.count > 0 {
            return productList[0].products.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.productTableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductTableViewCell
        cell.productName.text = productList[0].products[indexPath.item].name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let unixDate = productList[0].products[indexPath.item].releaseDate
        let date : String = unixDate.getDateStringFromUnixTime(dateStyle: dateFormatter.dateStyle)
        let formattedDate = date.getFormattedDate(string: date)
        
        cell.date.text = formattedDate
        cell.desc.text = productList[0].products[indexPath.item].description
        cell.price.text = String(format: "%.4f %@", productList[0].products[indexPath.item].price.value, productList[0].products[indexPath.item].price.currency.rawValue)
        cell.ratingView.rating = productList.first?.products[indexPath.item].rating ?? 0.0
        let url : URL?
        if productList.first?.products[indexPath.item].imageURL != nil {
            url = URL(string: productList.first?.products[indexPath.item].imageURL ?? "")
            cell.productImage?.sd_setImage(with: url, completed: nil)

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 10, width: productTableView.frame.size.width, height: 50))
        let myButton = UIButton(type: .custom)
        myButton.setTitle("© 2016 Check24", for: .normal)
//        myButton.contentHorizontalAlignment = .center

        myButton.addTarget(self, action: #selector(loadWebView), for: .touchUpInside)
        
        myButton.setTitleColor(UIColor.black, for: .normal)
        myButton.frame = CGRect(x: 0, y: 0, width: productTableView.frame.size.width - 60, height: 30)
        footerView.addSubview(myButton)
        footerView.backgroundColor = .red
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    //MARK: TableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "productDetailVC") as? ProductDetailViewController {
            detailVC.productName = self.productList[0].products[indexPath.item].name
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let unixDate = productList[0].products[indexPath.item].releaseDate
            let date : String = unixDate.getDateStringFromUnixTime(dateStyle: dateFormatter.dateStyle)
            let formattedDate = date.getFormattedDate(string: date)
            
            detailVC.productDate = formattedDate
            detailVC.productshortDesc = self.productList[0].products[indexPath.item].description
            detailVC.productRating = self.productList[0].products[indexPath.item].rating
            detailVC.productPrice = String(format: "%.4f %@", productList[0].products[indexPath.item].price.value, productList[0].products[indexPath.item].price.currency.rawValue)
            detailVC.productLongDesc = self.productList[0].products[indexPath.item].longDescription
            detailVC.productImageUrl = self.productList[0].products[indexPath.item].imageURL
            self.present(detailVC, animated:true, completion:nil)
        }
    }
    
    //MARK: Helper Methods
    //TODO: Move to separate Network File
    @objc func parseJSON () {
        
        guard let gitUrl = URL(string: "https://app.check24.de/products-test.json") else { return }
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let products = try decoder.decode(ProductListing.self, from: data)
                self.productList = [products]
                print(products.products[0].name)
                print(products.header.headerTitle)
                print(self.productList[0].products[0].name)
                DispatchQueue.global(qos: .background).async {
                    // Background Thread
                    DispatchQueue.main.async {
                        // Run UI Updates or call completion block
                        self.refreshControl.endRefreshing()
                        self.refresh()
                    }
                }
            } catch let err {
                print("Err", err)
            }
            }.resume()
            
        }
    
    @objc func refresh() {
        productTableView.delegate = self
        productTableView.dataSource = self
        self.headerTitle.text = self.productList[0].header.headerTitle
        self.subTitle.text = self.productList[0].header.headerDescription
        
        self.productTableView.reloadData()
    }
    
    //MARK: Present Check24WebViewController
    @objc func loadWebView() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Check24WebViewController") as? Check24WebViewController {
            self.present(viewController, animated:true, completion:nil)
        }
    }
}

