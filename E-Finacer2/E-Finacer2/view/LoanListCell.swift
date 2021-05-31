//
//  LoanListCell.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//

import UIKit
import Foundation
import SnapKit

class LoanListCell: UICollectionViewCell {
    
    var labelTitle: UILabel!
    var labelContent: UILabel!
    var imageViewRoot: UIImageView!
    var labelScheduled: UILabel!
    var labelLoanTime: UILabel!
    var labelLoanCash: UILabel!
    var labelLoanStatus: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        installUIImageView()
        installUILabelScheduled()
        installUILabelLoanTime()
        installUILabelLoanCash()
        installUILabelLoanStatus()
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Install widget.
    private func installUIImageView(){
        imageViewRoot = UIImageView()
        imageViewRoot.backgroundColor = UIColor.white
        imageViewRoot.layer.cornerRadius = 25
        imageViewRoot.isUserInteractionEnabled = true
        self.addSubview(imageViewRoot)
        
        imageViewRoot.snp.makeConstraints{ make in
            make.width.equalTo(self.contentView.frame.width - 80)
            make.height.equalTo(175)
            make.centerX.equalToSuperview()
        }
    }
    
    private func installUILabelScheduled(){
        labelScheduled = UILabel()
        labelScheduled.tag = 2001
        labelScheduled.font = .boldSystemFont(ofSize: 15)
        self.imageViewRoot.addSubview(labelScheduled)
        
        labelScheduled.snp.makeConstraints{ make in
            make.width.equalTo(120)
            make.height.equalTo(35)
            make.top.equalTo(self.imageViewRoot.snp.top).offset(5)
            make.left.equalTo(self.snp.left).offset(58)
        }
        
    }
    
    private func installUILabelLoanTime(){
        labelLoanTime = UILabel()
        labelLoanTime.tag = 2002
        self.imageViewRoot.addSubview(labelLoanTime)
        
        labelLoanTime.snp.makeConstraints{ make in
            make.width.equalTo(185)
            make.height.equalTo(35)
            make.top.equalTo(self.labelScheduled.snp.bottom).offset(8)
            make.left.equalTo(self.snp.left).offset(58)
        }
    }
    
    private func installUILabelLoanCash(){
        labelLoanCash = UILabel()
        labelLoanCash.tag = 2003
        self.imageViewRoot.addSubview(labelLoanCash)
        
        labelLoanCash.snp.makeConstraints{ make in
            make.width.equalTo(175)
            make.height.equalTo(35)
            make.top.equalTo(self.labelLoanTime.snp.bottom).offset(8)
            make.left.equalTo(self.snp.left).offset(58)
        }
    }
    
    private func installUILabelLoanStatus(){
        labelLoanStatus = UILabel()
        labelLoanStatus.tag = 2004
        self.imageViewRoot.addSubview(labelLoanStatus)
        
        labelLoanStatus.snp.makeConstraints{ make in
            make.width.equalTo(150)
            make.height.equalTo(35)
            make.top.equalTo(self.labelLoanCash.snp.bottom).offset(8)
            make.left.equalTo(self.snp.left).offset(58)
        }
        
    }
    
}

