//
//  ViewController.swift
//  Check24
//
//  Created by BilalSattar on 01/07/2018.
//  Copyright © 2018 Paras. All rights reserved.
//
import UIKit
class Check24WebViewController: UIViewController {
    var boxView = UIView()
    var eventID = String()
    
    @IBOutlet weak var check24WebView: UIWebView!
    
    @IBAction func closeWebView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Check24"
        let url = String(format: "https://m.check24.de/rechtliche-hinweise?deviceoutput=app", eventID)
        UIWebView.loadRequest(check24WebView)(NSURLRequest(url: NSURL(string: url)! as URL) as URLRequest)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addLoadingView() {
        // You only need to adjust this frame to move it anywhere you want
        boxView = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25, width: 180, height: 50))
        boxView.backgroundColor = .black
        boxView.alpha = 0.8
        boxView.layer.cornerRadius = 10
        
        //Here the spinnier is initialized
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityView.startAnimating()
        
        let textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
        textLabel.textColor = .gray
        textLabel.text = "Loading"
        
        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        
        view.addSubview(boxView)
    }
    
}

extension Check24WebViewController : UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        addLoadingView()
    }// show indicator
    func webViewDidFinishLoad(_ webView: UIWebView) {
        boxView.removeFromSuperview()
        
    } // hide indicator
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        boxView.removeFromSuperview()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        
        let str = request.url?.absoluteString
        NSLog(str!)
        return true
    }
}


