//
//  ViewController.swift
//  BlurEffectDemo-Swift
//
//  Created by Fourfire on 2020/9/8.
//  Copyright © 2020 zy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var tableView:UITableView!
    private var menuArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "UIBlurEffect"
        
        tableView = UITableView.init(frame: view.frame)
        tableView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        menuArray = ["UIVisualEffectView + UIBlurEffect",
                     "UIVisualEffectView + UIVibrancyEffect",
                     "UIVisualEffectView + UICustomBlurEffect"]
        
        self.perform(#selector(thankYouForYourSupport), with: nil, afterDelay: 60)
    }
    
    @objc func thankYouForYourSupport(){
        let alertVC = UIAlertController.init(title: "🌟感谢支持🌟", message: "如果觉得内容对你有帮助，不妨给我一颗小星星吧，非常感谢～", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "我偏不", style: .cancel, handler: nil)
        let sureAction = UIAlertAction.init(title: "好的", style: .default, handler: nil)
        alertVC.addAction(cancelAction)
        alertVC.addAction(sureAction)
        navigationController?.present(alertVC, animated: true, completion: nil)
    }
}


extension ViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identify:String = "cell"
        let cell: UITableViewCell
        if let currentCell = tableView.dequeueReusableCell(withIdentifier: identify) {
            cell = currentCell
        } else {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: identify)
        }
        cell.textLabel!.text = menuArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let vc = BlurEffectViewController.init()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = VibrancyEffectViewController.init()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = CustomBlurEffectViewController.init()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("click other")
        }
    }
    
}
