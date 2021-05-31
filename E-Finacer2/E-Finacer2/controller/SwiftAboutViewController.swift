//
//  AboutViewController.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//

import UIKit
import SnapKit
import AudioToolbox

class AboutViewController: UIViewController {
    
    var aboutViewModel: AboutViewModel!
    var aboutView: AboutView!
    
    private func initView(){
        aboutView = AboutView(frame: self.view.frame)
        self.view.addSubview(aboutView)
        
        aboutViewModel = AboutViewModel(label: aboutView.label, button: aboutView.button)
        aboutViewModel.labelText = "尊敬的用户，您好！E-金融是一款符合“互联网+”的金融科技产品，为数以百万计的用户提供琳琅满目的贷款方案：从低至万分之四的“轻享e借生活”的日息套餐，到审批不足半个工作日的无抵押信用刚需贷款“随行e键信用”，乃至小微企业的资质重组融借方案“友借e连企业”都遍布我们的产品。选择E-金融，就是选择未来！"
        aboutViewModel.buttonText = "我已知晓"
        aboutView.button.addTarget(self, action: #selector(buttonListener), for: UIControl.Event.touchUpInside)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        initView()
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Listener.
    @objc private func buttonListener(){
        let soundId = SystemSoundID(1520)
        AudioServicesPlaySystemSound(soundId)
        self.dismiss(animated: true, completion: nil)
    }

}
