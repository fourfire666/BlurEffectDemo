//
//  BlurEffectViewController.swift
//  BlurEffectDemo-Swift
//
//  Created by Fourfire on 2020/9/8.
//  Copyright © 2020 zy. All rights reserved.
//

import UIKit

class BlurEffectViewController: UIViewController {
    private var effectView : UIVisualEffectView!
    private var segmentControl : UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "UIVisualEffectView + UIBlurEffect"
        
        let imageView = UIImageView.init(frame: view.frame)
        imageView.image = UIImage.init(named: "Bristle Grass.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        view.addSubview(imageView)
        
        effectView = UIVisualEffectView.init(frame: view.frame)
        effectView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        view.addSubview(effectView)
        
        segmentControl = UISegmentedControl.init(items: ["None","ExtraLight","Light","Dark"])
        segmentControl.addTarget(self, action: #selector(segmentedControlValueChanged(control:)), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 3
        view.addSubview(segmentControl)
        
        self.segmentedControlValueChanged(control: segmentControl)
    }

    override func viewDidLayoutSubviews() {
        segmentControl.frame = CGRect.init(x: 10, y: view.frame.height - 50 - view.safeAreaInsets.bottom, width: view.frame.width - 20, height: 30)
    }
    
    @objc func segmentedControlValueChanged(control:UISegmentedControl) -> Void{
        let effectStyle:Int = control.selectedSegmentIndex - 1
        if effectStyle >= 0 {
            effectView.isHidden = false
            effectView.effect = UIBlurEffect.init(style: UIBlurEffect.Style(rawValue: effectStyle)!)
        }else{
            effectView.isHidden = true
        }
    }

}

