//
//  AppDelegate.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let repaymentEvent = UIApplicationShortcutItem(type: "com.e_financer.repayment", localizedTitle: "即刻还贷")
        let loanEvent = UIApplicationShortcutItem(type: "com.e_financer.loan", localizedTitle: "轻松e借款")
        application.shortcutItems = [repaymentEvent, loanEvent]
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        if shortcutItem.type == "com.e_financer.repayment" {
            print("------> EXECUTE 3D TOUCH of REPAYMENT.")
            let rootVC = self.window?.rootViewController
            rootVC?.present(RepaymentViewController(), animated: true, completion: nil)
        } else if shortcutItem.type == "com.e_financer.loan"{
            print("------> EXECUTE 3D TOUCH of LOAN.")
            let rootVC = self.window?.rootViewController
            rootVC?.present(LoanViewController(), animated: true, completion: nil)
        }
    }

}

