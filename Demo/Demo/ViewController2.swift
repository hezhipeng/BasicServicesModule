//
//  ViewController2.swift
//  Demo
//
//  Created by Frank.he on 2018/4/25.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import UIKit
import BasicServicesModule

class ViewController2: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        customNavigation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        print("will appear")
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            
            
            self.navigationController?.navigationBar.customBar(backgroundColor: .blue, titleTextAttributes: [NSAttributedString.Key.foregroundColor: UIColor.red,
                                                                                                             NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        }
    }

    /// 是否显示关闭按钮
    ///
    /// - Returns: Bool
    @objc override func shouldAddCloceButton() -> Bool {
        return false
    }
    
    deinit {
        Cansole.log("deinit")
    }

}
