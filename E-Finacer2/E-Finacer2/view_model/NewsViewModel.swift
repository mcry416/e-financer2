//
//  NewsViewModel.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//

import Foundation
import UIKit
import WebKit

class NewsViewModel{
    private weak var webView: WKWebView!
    
    init(webView: WKWebView) {
        self.webView = webView
    }
    
    var webViewInfo: String?{
        get{
            return webView.title
        } set{
            let url = URL(string: newValue ?? "https://www.baidu.com")!
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
