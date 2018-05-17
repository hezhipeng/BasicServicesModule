//
//  ViewController1.swift
//  Demo
//
//  Created by Frank.he on 2018/4/25.
//  Copyright © 2018年 一城一家网络科技有限公司. All rights reserved.
//

import UIKit
import SwifterSwift

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.promptMessage("快捷")
        self.alert("alert")
        
//        DispatchQueue.main.async {
//            self.navigationController?.navigationBar.shadowImage = UIImage()
//            self.navigationController?.navigationBar.tintColor = .yellow
//            self.navigationController?.navigationBar.setBackgroundImage(UIImage(color: .yellow, size: CGSize(width: 1, height: 1)), for: .default)
//
//        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("will appear")
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            
        
        self.navigationController?.navigationBar.customBar(backgroundColor: .yellow, titleTextAttributes: [NSAttributedStringKey.foregroundColor: UIColor.red,
                                                                                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
        }
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
