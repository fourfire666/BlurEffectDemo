//
//  CustomBlurEffectViewController.swift
//  BlurEffectDemo-Swift
//
//  Created by Fourfire on 2020/9/8.
//  Copyright © 2020 zy. All rights reserved.
//

import UIKit

class CustomBlurEffectViewController: UIViewController {
    private var effectView : UIVisualEffectView!
    private var slider : UISlider!
    private var blurRadiusLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "UIVisualEffectView + UICustomBlurEffect"
        
        let imageView = UIImageView.init(frame: view.frame)
        imageView.image = UIImage.init(named: "Bristle Grass.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        view.addSubview(imageView)
        
        effectView = UIVisualEffectView.init(frame: view.frame)
        effectView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        view.addSubview(effectView)
        
        slider = UISlider.init()
        slider.maximumValue = 50.0
        slider.minimumValue = 0.0
        slider.value = 10.0
        slider.addTarget(self, action: #selector(sliderValueChanged(slider:)), for: .valueChanged)
        view.addSubview(slider)
        
        blurRadiusLabel = UILabel.init()
        blurRadiusLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(blurRadiusLabel)
        
        self.sliderValueChanged(slider: slider)
    }
    
    override func viewDidLayoutSubviews() {
        blurRadiusLabel.frame = CGRect.init(x: 10, y: view.frame.height - 50 - view.safeAreaInsets.bottom, width: 100, height: 30)
        slider.frame = CGRect.init(x: blurRadiusLabel.frame.maxX + 10, y: blurRadiusLabel.frame.minY, width: view.frame.width - blurRadiusLabel.frame.maxX - 20, height: 30)
    }
    
    @objc func sliderValueChanged(slider:UISlider) -> Void{
        blurRadiusLabel.text = String.init(format: "BlurRadius:%.1f", slider.value)
        effectView.effect = makeCustomZoomBlurEffectWithRadius(Double(slider.value));
    }
    
}
