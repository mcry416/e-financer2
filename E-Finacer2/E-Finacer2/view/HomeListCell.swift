//
//  HomeListCell.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//

import UIKit
import Foundation
import SnapKit

class HomeListCell: UICollectionViewCell {
    
    var labelTitle: UILabel!
    var labelContent: UILabel!
    var imageViewRoot: UIImageView!
    var buttonLoan: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        installUIImageView()
        installUILabel()
        installUILabel2()
        installUIButton()
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Install widget.
    private func installUIImageView(){
        imageViewRoot = UIImageView()
        imageViewRoot.backgroundColor = UIColor.white
        imageViewRoot.layer.cornerRadius = 15
        imageViewRoot.isUserInteractionEnabled = true
        self.addSubview(imageViewRoot)
        
        imageViewRoot.snp.makeConstraints{ make in
            make.width.equalTo(self.contentView.frame.width - 60)
            make.height.equalTo(180)
            make.centerX.equalToSuperview()
        }
    }
    
    private func installUILabel(){
        labelTitle = UILabel()
        labelTitle.font = UIFont.boldSystemFont(ofSize: 20)
        labelTitle.textColor = UIColor.black
        labelTitle.tag = 1002
        self.imageViewRoot.addSubview(labelTitle)
        
        labelTitle.snp.makeConstraints{ make in
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.top.equalTo(self.imageViewRoot.snp.top).offset(5)
            make.left.equalTo(self.snp.left).offset(68)
        }
    }
    
    private func installUILabel2(){
        labelContent = UILabel()
        labelContent.text = ""
        labelContent.numberOfLines = 5
        labelContent.tag = 1004
        self.imageViewRoot.addSubview(labelContent)
        
        labelContent.snp.makeConstraints{ make in
            make.width.equalTo(self.contentView.frame.width - 110)
            make.left.equalTo(self.labelTitle.snp.left)
            make.top.equalTo(self.labelTitle.snp.bottom).offset(18)
        }
    }
    
    private func installUIButton(){
        buttonLoan = UIButton()
        buttonLoan.setTitle("即刻e借", for: UIControl.State.normal)
        buttonLoan.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        buttonLoan.isUserInteractionEnabled = false
        buttonLoan.tag = 1003
        self.imageViewRoot.addSubview(buttonLoan)
        
        buttonLoan.snp.makeConstraints{ make in
            make.width.equalTo(71)
            make.height.equalTo(40)
            make.left.equalTo(self.labelTitle.snp.left)
            make.bottom.equalTo(self.imageViewRoot.snp.bottom).offset(-5)
        }
    }
    
}
