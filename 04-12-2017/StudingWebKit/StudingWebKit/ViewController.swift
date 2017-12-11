//
//  ViewController.swift
//  StudingWebKit
//
//  Created by Aloc SP08608 on 04/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {

    var navegador : WKWebView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let config = WKWebViewConfiguration()
        navegador = WKWebView(frame: .zero, configuration: config)
        
        navegador.uiDelegate = self

        view.addSubview(navegador)
        
        navegador.translatesAutoresizingMaskIntoConstraints = false
          
       view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[newView]-0-|", options: [], metrics: nil, views: ["newView": navegador]))

        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[newView]-0-|", options: [], metrics: nil, views: ["newView": navegador]))

        let url = URL(string : "https://www.google.com.br")
        let urlRequest = URLRequest(url : url!)
        navegador.load(urlRequest)


    }

    private func addNewInternalView(parent : UIView, newView : UIView) {
        parent.addSubview(newView)
        
        newView.translatesAutoresizingMaskIntoConstraints = false
        
        let viewsDictionary = ["newView": newView]
        
        parent.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[newView]-0-|", options: [], metrics: nil, views: viewsDictionary))
        
        parent.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[newView]-0-|", options: [], metrics: nil, views: viewsDictionary))

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

