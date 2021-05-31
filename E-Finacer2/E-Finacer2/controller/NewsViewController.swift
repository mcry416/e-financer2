//
//  NewsViewController.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//

import UIKit

class NewsViewController: UIViewController {
    
    var newsViewModel: NewsViewModel!
    var newsView: NewsView!
    
    private func initView(){
        newsView = NewsView(frame: self.view.frame)
        self.view.addSubview(newsView)
        
        newsViewModel = NewsViewModel(webView: newsView.webView)
        newsViewModel.webViewInfo = "https://m.baidu.com/sf/vsearch?pd=realtime&word=%E5%A4%AE%E8%A1%8C%20%E8%B4%B7%E6%AC%BE&tn=vsearch&sa=vs_ala_realtime&lid=9495618598439035995&ms=1&from=1086k&atn=index&ivk_sa=1023197a"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        initView()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

