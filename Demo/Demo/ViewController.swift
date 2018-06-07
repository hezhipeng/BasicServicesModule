//
//  ViewController.swift
//  Demo
//
//  Created by Frank.he on 2018/4/25.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import UIKit
import BasicServicesModule

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Cansole.log(self)
        
        self.title = "frank"
        self.promptMessage("快捷")
//        self.alert("alert")
//        UINavigationBar.customBar()
        
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func click(_ sender: Any) {
        
//        self.promptMessage("市领导看风景")

        self.showLoading()
        let _ = NetworkService.shared.login(mobileNo: "18611627579", password: "123456")
            .subscribe(onNext: { [weak self] (result) in
                Cansole.log(result)
                self?.hideLoading()
            })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("will appear")
        self.navigationController?.navigationBar.customBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

