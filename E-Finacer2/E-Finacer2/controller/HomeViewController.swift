//
//  HomeViewController.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//

import UIKit
import SnapKit
import Toast
import FSPagerView
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, FSPagerViewDelegate, FSPagerViewDataSource {
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        fsPageControl.currentPage = index
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        5
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)

        if(imagesArray.isEmpty){
            let imageName = images[index]
            cell.imageView?.image = UIImage(named: imageName)
        } else{
            let url = imagesArray[index]
            cell.imageView?.image = UIImage.loadWithURL(url:url)
        }
        
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL_ID", for: indexPath) as! HomeListCell
        
        let label = cell.viewWithTag(1002) as! UILabel
        label.text = HomeList.getLabelTitle(indexPath.row)
        
        let labelContent = cell.viewWithTag(1004) as! UILabel
        labelContent.text = HomeList.getLabelContent(indexPath.row)
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        let button = cell!.viewWithTag(1003) as! UIButton
        button.addTarget(self, action: #selector(clickListener), for: UIControl.Event.touchUpInside)
        print("------> CLICK CELLL ITEM.")
        
        if(InitConfig.isEnterUser() == true){
            showLoanView(index: indexPath.row)
        } else{
            self.view.makeToast("当前您还未登录，不可操作")
        }
    }
    
    var homeCollectionView: UICollectionView!
    var fsPagerView: FSPagerView!
    var fsPageControl = FSPageControl()
    var images: Array<String> = ["f1", "f2", "f3", "f4", "f5"]
    private lazy var storeUserService = StoreUserServiceImpl()
    var imagesArray: Array<String> = Array<String>()
    
    private func initView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: self.view.frame.width, height: 180)
        
        fsPagerView = FSPagerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        fsPagerView.delegate = self
        fsPagerView.dataSource = self
        fsPagerView.automaticSlidingInterval = 3.0
        fsPagerView.isInfinite = true
        fsPagerView.transformer = FSPagerViewTransformer(type: .zoomOut)
        fsPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(fsPagerView)
        
        fsPageControl.numberOfPages = 5
        self.view.addSubview(fsPageControl)

        homeCollectionView = UICollectionView(frame: CGRect(x: 0, y: 150, width: self.view.frame.width, height: 700), collectionViewLayout: flowLayout)
        homeCollectionView.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.998, alpha: 1.0)
        homeCollectionView.isUserInteractionEnabled = true
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeCollectionView.register(HomeListCell.self, forCellWithReuseIdentifier: "CELL_ID")
        self.view.addSubview(homeCollectionView)
        
        homeCollectionView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(self.view.frame.height - 325)
            make.top.equalTo(self.fsPagerView.snp.bottom).offset(15)
        }
        
        fsPagerView.snp.makeConstraints{ make in
            make.width.equalTo(self.view.frame.width - 60)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(15)
            make.height.equalTo(200)
        }
        
        fsPageControl.snp.makeConstraints{ make in
            make.width.equalTo(150)
            make.height.equalTo(20)
            make.centerX.equalTo(self.fsPagerView)
            make.bottom.equalTo(self.fsPagerView.snp.bottom).offset(-10)
        }

    }
    
    private func initData(){
        let url = "http://192.168.0.2:8080/ef/banner"
        Alamofire.AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                print("-------> NETWORK:\(json)")
                let jsonData = JSON(json)

                for i in 0..<jsonData.count {
                    self.imagesArray.append(jsonData[i]["imageUrl"].string!)
                }
                
                for i in 0..<self.imagesArray.count{
                    print("------> PASER:\(self.imagesArray[i])")
                }
                
                self.fsPagerView.reloadData()
                
                // Success in request and do a async or sync(NOT UI) task here.
                break
            case .failure(let error):
                print("error:\(error)")
                self.view.makeToast("借贷失败，请检查网络状态")
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
    
    // MARK: - Listener block.
    @objc private func clickListener(){
        print("------> CLICK.")
    }
    
    @objc private func showLoanView(index: Int){
        let alertController = UIAlertController(title: "e借贷", message: "填写相应的借贷款额", preferredStyle: UIAlertController.Style.alert)
        let alertActionLoan = UIAlertAction(title: "借贷", style: UIAlertAction.Style.default) { action in
            print("-----> \(alertController.textFields?.first?.text ?? "None")")
            var array: Array<User> = self.storeUserService.getUser()
            self.doLoan(InitConfig.getUser(), HomeList.getService(index), (alertController.textFields?.first?.text)!)
        }
        let alertActionCacel = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: { action in
            self.view.makeToast("欢迎下次前来借贷")
        })
        alertController.addAction(alertActionLoan)
        alertController.addAction(alertActionCacel)
        alertController.addTextField(){ textField in
            textField.placeholder = "请输入借贷金额"
            textField.keyboardType = .numberPad
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func doLoan(_ phone: String, _ service: String, _ loanCash: String){
        let url = "http://192.168.0.2:8080/ef/do_loan/\(phone)/\(service)/\(loanCash)/\("2021-05-21")"
        Alamofire.AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                print("-------> NETWORK:\(json)")
                let jsonData = JSON(json)
                print("------> PASER \(jsonData[0]["status"].string!)")
                if(Int(jsonData[0]["status"].string!) == 1){
                    self.view.makeToast("借贷成功，您的借贷金额为：\(loanCash)元")
                } else {
                    self.view.makeToast("借贷失败")
                }
                // Success in request and do a async or sync(NOT UI) task here.
                break
            case .failure(let error):
                print("error:\(error)")
                self.view.makeToast("借贷失败，请检查网络状态")
                break
            }
        }
        
    }

}

extension UIImage {
    class func loadWithURL(url: String) -> UIImage {
        let url = URL(string: url)!;
        var img = UIImage();
        
        do{
            let data = try Data(contentsOf: url);
            img = UIImage(data: data)!;
        } catch let err as NSError {
            print("下载图片出错：\\(err)");
        }
        
        return img;
    }
}
