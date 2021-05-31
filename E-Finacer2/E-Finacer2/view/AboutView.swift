//
//  AboutView.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//

import Foundation
import UIKit
import SnapKit

class AboutView: UIView{
    var label: UILabel!
    var button: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        installUILabel()
        installUIButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Install weidget.
    private func installUILabel(){
        label = UILabel()
        label.text? = "Welcome to use E-Financer."
        label.textColor = UIColor.black
        label.numberOfLines = 10
        self.addSubview(label)
        label.snp.makeConstraints{ make in
            make.width.equalTo(self.frame.width - 80)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(100)
        }
    }
    
    private func installUIButton(){
        button = UIButton()
        button.setTitle("我已知晓", for: UIControl.State.normal)
        button.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        self.addSubview(button)
        button.snp.makeConstraints{ make in
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-90)
        }
    }
    
}
