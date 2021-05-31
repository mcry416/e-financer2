//
//  ViewController.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//

import UIKit
import Tabman
import Pageboy

class ViewController: TabmanViewController, PageboyViewControllerDataSource, TMBarDataSource{
    
    // Return ViewControllers's count.
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    // Return current index ViewController.
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    // Set default page.
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

    // Set BarItem's title.
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "首页")
        case 1:
            return TMBarItem(title: "新闻")
        default:
            return TMBarItem(title: "首页")
        }
    }
    
    // Set ViewController's instance count.
    private var viewControllers = [HomeViewController(), NewsViewController()]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        // Set data source with self.
        self.dataSource = self

        // Create bar and set style.
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .progressive
        bar.buttons.customize { (button) in
            button.tintColor = .black
            button.selectedTintColor = .systemBlue
        }
        bar.indicator.overscrollBehavior = .compress
        bar.indicator.weight = .light
        
        
     //   self.bar.items = [Item(title: "Page 1"), Item(title: "Page 2")]
        
        // Add to view
        addBar(bar, dataSource: self, at: .top)
    }
    
}
