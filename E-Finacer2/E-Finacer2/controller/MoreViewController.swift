//
//  MoreViewController.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//

import UIKit
import SnapKit
import FSPagerView
import Alamofire
import SwiftyJSON
import Toast

class MoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellId", for: indexPath)
        cell.textLabel?.text = dataArray?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            showAlertAction()
            print("")
        case 1:
            showRegister()
            print("")
        case 2:
            let loanVC = LoanViewController()
            loanVC.modalPresentationStyle = .formSheet
            present(loanVC, animated: true, completion: nil)
            print("")
        case 3:
            let repaymentVC = RepaymentViewController()
            repaymentVC.modalPresentationStyle = .formSheet
            present(repaymentVC, animated: true, completion: nil)
            print("")
        case 4:
            let aboutVC = AboutViewController!
            aboutVC = AboutViewController.init()
            aboutVC.modalPresentationStyle = .formSheet
            present(aboutVC, animated: true, completion: nil)
            print("")
        default:
            print("")
        }
    }
    
    
    // MARK: - Class variable.
    var imageViewRoot = UIImageView()
    var imageViewIcon = UIImageView()
    var labelPhone = UILabel()
    var dataArray: Array<String>?
    var tableView: UITableView!
    
    private lazy var storeUserService = StoreUserServiceImpl()
    
    
    // MARK: - Init the view.
    private func initView(){
        imageViewRoot.layer.cornerRadius = 20
        imageViewRoot.backgroundColor = UIColor.white
        self.view.addSubview(imageViewRoot)
        
        self.imageViewRoot.addSubview(imageViewIcon)
      //  self.view.addSubview(imageViewIcon)
        imageViewIcon.image = UIImage(named: "ef_icon")
          
        labelPhone.text = "Nil"
        labelPhone.font = UIFont.systemFont(ofSize: 25)
        self.imageViewRoot.addSubview(labelPhone)
     //   self.view.addSubview(labelPhone)
        
        dataArray = ["登陆", "注册", "借贷条目", "还款", "关于"]
        tableView = UITableView()
        tableView.register(NSClassFromString("UITableViewCell"), forCellReuseIdentifier: "TableViewCellId")
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 20
        
        imageViewRoot.snp.makeConstraints{ make in
            make.width.equalTo(self.view.frame.width - 40)
            make.height.equalTo(150)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(25)
        }
        
        imageViewIcon.snp.makeConstraints{ make in
            make.size.equalTo(85)
            make.top.equalTo(self.imageViewRoot.snp.top).offset(35)
            make.left.equalTo(self.imageViewRoot.snp.left).offset(30)
        }
        
        labelPhone.snp.makeConstraints{ make in
            make.width.equalTo(150)
            make.height.equalTo(35)
            make.top.equalTo(self.imageViewRoot.snp.top).offset(65)
            make.right.equalTo(self.imageViewRoot.snp.right).offset(-30)
        }
        
        tableView.snp.makeConstraints{ make in
            make.width.equalTo(self.view.frame.width - 40)
            make.height.equalTo(225)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.imageViewIcon.snp.bottom).offset(50)
        }
        
    }
    
    // Init the user's basic information by plist and SQL.
    private func initConfig(){
        if(InitConfig.isEnterUser() == true){
            self.labelPhone.text = "Nil"
        } else{
            var array: Array<User> = storeUserService.getUser()
       //     self.labelPhone.text = array[0].phone!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.998, alpha: 1.0)
        
        initConfig()
        
        initView()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Function block.
    
    private func showAlertAction(){
        let alertController = UIAlertController(title: "登陆", message: "填写准确的账号及密码", preferredStyle: UIAlertController.Style.alert)
        let alertActionLogin = UIAlertAction(title: "登陆", style: UIAlertAction.Style.default) { action in
            print("-----> \(alertController.textFields?.first?.text ?? "None")")
            
            self.loginRequest((alertController.textFields?.first?.text)!, (alertController.textFields?.last?.text)!)

            /*
            self.storeUserService.setUser(phone: alertController.textFields?.first?.text ?? "000000", password: alertController.textFields?.last?.text ?? "000000")
            */
            
        }
        let alertActionCacel = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: { action in
            InitConfig.setUnstoreUser()
        })
        alertController.addAction(alertActionLogin)
        alertController.addAction(alertActionCacel)
        alertController.addTextField(){ textField in
            textField.placeholder = "请输入账号"
        }
        alertController.addTextField(){ textField in
            textField.placeholder = "请输入密码"
            textField.isSecureTextEntry = true
        }
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    private func showRegister(){
        let alertController = UIAlertController(title: "注册", message: "填写未注册的手机号及密码", preferredStyle: UIAlertController.Style.alert)
        let alertActionLogin = UIAlertAction(title: "注册", style: UIAlertAction.Style.default) { action in
            print("-----> \(alertController.textFields?.first?.text ?? "None")")
            self.registerRequest((alertController.textFields?.first?.text)!, (alertController.textFields?.last?.text)!)
            
        }
        let alertActionCacel = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: { action in
            InitConfig.setUnstoreUser()
        })
        alertController.addAction(alertActionLogin)
        alertController.addAction(alertActionCacel)
        alertController.addTextField(){ textField in
            textField.placeholder = "请输入账号（手机号）"
        }
        alertController.addTextField(){ textField in
            textField.placeholder = "请输入密码"
            textField.isSecureTextEntry = true
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func loginRequest(_ phone: String,_ password: String) -> String{
        var temp = "Nil"
        let url = "http://192.168.0.2:8080/ef/login/\(phone)/\(password)"
        Alamofire.AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                print("------> NETWORK:\(json)")
                let jsonData = JSON(json)
                
                // Registion succeed.
                if(Int(jsonData[0]["status"].string!) == 1){
                    temp = phone
                    self.labelPhone.text = temp
                    self.view.makeToast("登陆成功")
                    self.storeUserService.setUser(phone: phone, password: password)
                    InitConfig.setStoreUser()
                    InitConfig.setUser(phone)
                } else{
                    self.view.makeToast("登陆失败")
                    InitConfig.setUnstoreUser()
                }
                // Success in request and do an async or sync(NOT UI) task here.
                break
            case .failure(let error):
                print("error:\(error)")
                self.view.makeToast("登陆失败，请检查网络状态")
                break
            }
        }
        
        
        return temp

    }
    
    private func registerRequest(_ phone: String,_ password: String){
        let url = "http://192.168.0.2:8080/ef/register/\(phone)/\(password)"
        Alamofire.AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                print("-------> NETWORK:\(json)")
                let jsonData = JSON(json)
                print("------> PASER \(jsonData[0]["status"].string!)")
                if(Int(jsonData[0]["status"].string!) == 1){
                    self.view.makeToast("注册成功")
                } else {
                    // Registion failed.
                    self.view.makeToast("注册失败，请检查账号或密码是否符合要求")
                }
                // Success in request and do a async or sync(NOT UI) task here.
                break
            case .failure(let error):
                print("error:\(error)")
                self.view.makeToast("注册失败，请检查网络状态")
                break
            }
        }
    }


}
