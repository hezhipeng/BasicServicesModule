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
        
        self.view.showLoading()
        backIconColor = UIColor.red
        customNavigation()
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
        printX("deinit")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("will appear")
        super.viewWillAppear(animated)
        
        
        DispatchQueue.main.async {
            
            

            self.navigationController?.navigationBar.customBar(backgroundColor: .yellow, titleTextAttributes: [NSAttributedString.Key.foregroundColor: UIColor.red,
                                                                                                               NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        }
    }

    @objc func update() {
        
        self.showLoading()
        let _ = NetworkService.shared.login(mobileNo: "18611627579", password: "123456")
            .subscribe(onNext: { [weak self] (result) in
                printX(result)
                self?.hideLoading()
            })
        
//        (UIApplication.shared.delegate as? AppDelegate)?.updateTabbar()
    }

}
