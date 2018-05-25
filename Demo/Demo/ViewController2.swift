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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        print("will appear")
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            
            
            self.navigationController?.navigationBar.customBar(backgroundColor: .blue, titleTextAttributes: [NSAttributedStringKey.foregroundColor: UIColor.red,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
        }
    }

    /// 是否显示关闭按钮
    ///
    /// - Returns: Bool
    @objc override func shouldAddCloceButton() -> Bool {
        return false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
