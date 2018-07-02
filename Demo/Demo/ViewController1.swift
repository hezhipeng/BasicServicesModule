//
//  ViewController1.swift
//  Demo
//
//  Created by Frank.he on 2018/4/25.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import UIKit
import SwifterSwift
import BasicServicesModule

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.promptMessage("快捷")
        
//        DispatchQueue.main.async {
//            self.navigationController?.navigationBar.shadowImage = UIImage()
//            self.navigationController?.navigationBar.tintColor = .yellow
//            self.navigationController?.navigationBar.setBackgroundImage(UIImage(color: .yellow, size: CGSize(width: 1, height: 1)), for: .default)
//
//        }
        
        
        let btn1 = UIButton(type: .system)
        btn1.frame = CGRect.init(x: 100, y: 200, width: 60, height: 30)
        btn1.setTitle("更改", for: .normal)
        btn1.addTarget(self, action: #selector(update), for: .touchUpInside)
        self.view .addSubview(btn1)
    }

    deinit {
        Cansole.log("deinit")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("will appear")
        super.viewWillAppear(animated)
        
        
        DispatchQueue.main.async {
            
            self.alert("alert")

        self.navigationController?.navigationBar.customBar(backgroundColor: .yellow, titleTextAttributes: [NSAttributedStringKey.foregroundColor: UIColor.red,
                                                                                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
        }
    }

    @objc func update() {
        
        self.showLoading()
        let _ = NetworkService.shared.login(mobileNo: "18611627579", password: "123456")
            .subscribe(onNext: { [weak self] (result) in
                Cansole.log(result)
                self?.hideLoading()
            })
        
//        (UIApplication.shared.delegate as? AppDelegate)?.updateTabbar()
    }

}
