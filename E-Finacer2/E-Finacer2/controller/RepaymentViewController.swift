//
//  RepaymentViewController.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//

import UIKit
import SnapKit
import AudioToolbox
import Alamofire
import SwiftyJSON

class RepaymentViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL_ID_LOAN", for: indexPath) as! LoanListCell
        
        let labelScheduled = cell.viewWithTag(2001) as! UILabel
     //   labelScheduled.text = "2021-0\(indexPath.row + 1)期"
        labelScheduled.text = array[indexPath.row].loanTime
        
        let labelLoanTime = cell.viewWithTag(2002) as! UILabel
        labelLoanTime.text = "还款时间：2021-0\(indexPath.row + 1)-19"
        
        let labelLoanCash = cell.viewWithTag(2003) as! UILabel
        labelLoanCash.text = "本期待还：\(array[indexPath.row].shouldRepayment!) （元）"
        
        let labelLoanStatus = cell.viewWithTag(2004) as! UILabel
        if(array[indexPath.row].isEnd == "true"){
            labelLoanStatus.text = "还款状态：已还"
        } else if (array[indexPath.row].isEnd == "false") {
            labelLoanStatus.text = "还款状态：待还"
        }
            
        return cell
    }
    
    // MARK: - Class variable.
    var imageViewRoot = UIImageView()
    var label = UILabel()
    var labelShouldRepayment = UILabel()
    var labelCash = UILabel()
    var buttonRepayment = UIButton(type: .system)
    var loanCollectionView: UICollectionView!
    var array: Array<BrowserLoanItem> = Array<BrowserLoanItem>()
    
    // MARK: - Init the view.
    private func initView(){
        label.text = "即刻还款"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        self.view.addSubview(label)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame.size = CGSize(width: (self.view.frame.width - 80), height: 170)
        blurView.layer.masksToBounds = true
        blurView.layer.cornerRadius = 25
        
        imageViewRoot.image = UIImage(named: "repayment_blur")
        imageViewRoot.contentMode = .scaleAspectFit
        imageViewRoot.isUserInteractionEnabled = true
        self.view.addSubview(imageViewRoot)
        
        self.imageViewRoot.addSubview(blurView)
        
        labelShouldRepayment.text = "本期待还（元）"
        labelShouldRepayment.font = UIFont.boldSystemFont(ofSize: 24)
        labelShouldRepayment.textColor = UIColor.white
        self.imageViewRoot.addSubview(labelShouldRepayment)
        
        let vibraView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        vibraView.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        blurView.contentView.addSubview(vibraView)
        labelCash.text = "8800"
        labelCash.font = UIFont.italicSystemFont(ofSize: 40)
        vibraView.contentView.addSubview(labelCash)
        
        buttonRepayment.setTitle("即刻还款", for: UIControl.State.normal)
        buttonRepayment.setTitleColor(UIColor.gray, for: UIControl.State.selected)
        buttonRepayment.layer.cornerRadius = 8
        buttonRepayment.addTarget(self, action: #selector(repaymentListener), for: UIControl.Event.touchUpInside)
        buttonRepayment.isEnabled = true
        self.imageViewRoot.addSubview(buttonRepayment)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: self.view.frame.width, height: 180)

        loanCollectionView = UICollectionView(frame: CGRect(x: 0, y: 150, width: self.view.frame.width, height: 700), collectionViewLayout: flowLayout)
        loanCollectionView.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.998, alpha: 1.0)
        loanCollectionView.isUserInteractionEnabled = true
        loanCollectionView.delegate = self
        loanCollectionView.dataSource = self
        loanCollectionView.register(LoanListCell.self, forCellWithReuseIdentifier: "CELL_ID_LOAN")
        self.view.addSubview(loanCollectionView)
        
        // Constraight.
        label.snp.makeConstraints{ make in
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
        }
        
        imageViewRoot.snp.makeConstraints{ make in
            make.width.equalTo(self.view.frame.width - 80)
            make.height.equalTo(170)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.label.snp.bottom).offset(20)
        }
        
        labelShouldRepayment.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(40)
            make.top.equalToSuperview().offset(10)
        }
        
        labelCash.snp.makeConstraints{ make in
            make.width.equalTo(140)
            make.height.equalTo(40)
            make.top.equalTo(self.labelShouldRepayment.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(40)
        }
        
        buttonRepayment.snp.makeConstraints{ make in
            make.width.equalTo(70)
            make.height.equalTo(30)
            make.top.equalTo(self.labelCash.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(40)
        }
        
        loanCollectionView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(self.view.frame.height - 290 - self.imageViewRoot.frame.height)
            make.top.equalTo(self.imageViewRoot.snp.bottom).offset(20)
        }
    }
    
    private func initData(){
        let phone = InitConfig.getUser()
        let url = "http://192.168.0.2:8080/ef/item_loan/my/17356900019"
        Alamofire.AF.request(url).responseJSON { [self] (response) in
            switch response.result {
            case .success(let json):
                print("-------> NETWORK:\(json)")
                let jsonData = JSON(json)
           //     print("------> PASER \(jsonData[0]["status"].string!)")
                print("------> SIZE:\(jsonData.count)")
                var size: Int = Int(jsonData.count)

                for i in 0..<size{
                    var item = BrowserLoanItem(shouldRepayment: jsonData[i]["should_repayment"].string!,
                                               loanTime: jsonData[i]["loan_time"].string!,
                                               isEnd: jsonData[i]["is_end"].string!)
                    array.append(item)
                }
                self.loanCollectionView.reloadData()
                
                break
            case .failure(let error):
                print("error:\(error)")
                self.view.makeToast("还款失败，请检查网络状态")
                break
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.998, alpha: 1.0)
        
        initView()
        
        initData()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Function block.
 
    @objc private func repaymentListener(){
        // Shake.
        let soundId = SystemSoundID(1520)
        AudioServicesPlaySystemSound(soundId)
        print("------> SHAKE.")
        showAlertAction()
    }
    
    private func showAlertAction(){
        let alertController = UIAlertController(title: "即刻还款", message: "", preferredStyle: UIAlertController.Style.alert)
        let alertActionLogin = UIAlertAction(title: "还款", style: UIAlertAction.Style.default) { action in
            print("-----> \(alertController.textFields?.first?.text ?? "None")")
            self.loanRequest(InitConfig.getUser(), (alertController.textFields?.first?.text)!, (alertController.textFields?.last?.text)!)

        }
        let alertActionCacel = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: { action in
        })
        alertController.addAction(alertActionLogin)
        alertController.addAction(alertActionCacel)
        alertController.addTextField(){ textField in
            textField.placeholder = "请输入还款服务"
        }
        alertController.addTextField(){ textField in
            textField.placeholder = "请输入还款金额"
        }
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    private func loanRequest(_ phone: String,_ service: String, _ cash: String){
        let url = "http://192.168.0.2:8080/ef/repayment/17356900019/\(service)/\(cash)"
        Alamofire.AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                print("------> NETWORK:\(json)")
                let jsonData = JSON(json)
                
                // Registion succeed.
                if(Int(jsonData[0]["status"].string!) == 1){
                    self.view.makeToast("还款成功")
                } else{
                    self.view.makeToast("还款失败")
                }
                // Success in request and do an async or sync(NOT UI) task here.
                break
            case .failure(let error):
                print("error:\(error)")
                self.view.makeToast("登陆失败，请检查网络状态")
                break
            }
        }

    }

}
