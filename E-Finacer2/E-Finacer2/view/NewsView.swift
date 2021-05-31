//
//  NewsView.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//
//
import Foundation
import SnapKit
import UIKit
import WebKit

class NewsView: UIView{
    var webView: WKWebView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        installWKWebView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Install weidget.
    private func installWKWebView(){
        let config = WKWebViewConfiguration()
        webView = WKWebView(frame: self.frame, configuration: config)
        webView.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.998, alpha: 1.0)
        let processPoll = WKProcessPool()
        config.processPool = processPoll
        let prefrence = WKPreferences()
        prefrence.javaScriptEnabled = true
        config.preferences = prefrence
        self.addSubview(webView)
        
        webView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(self.frame.height)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
        }
    }
    
}
