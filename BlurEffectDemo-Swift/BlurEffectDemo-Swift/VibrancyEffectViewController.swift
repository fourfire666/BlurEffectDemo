//
//  VibrancyEffectViewController.swift
//  BlurEffectDemo-Swift
//
//  Created by Fourfire on 2020/9/8.
//  Copyright © 2020 zy. All rights reserved.
//

import UIKit

class VibrancyEffectViewController: UIViewController {
    private var labelEffectView1:UIVisualEffectView!
    private var labelEffectView2:UIVisualEffectView!
    private var imageEffectView1:UIVisualEffectView!
    private var imageEffectView2:UIVisualEffectView!
    private var separatorEffectView1:UIVisualEffectView!
    
    private var useVibrancy:Bool = true
    private var effectStyle:UIBlurEffect.Style! = UIBlurEffect.Style.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "UIVisualEffectView + UIVibrancyEffect"

        let imageView = UIImageView.init(frame: view.frame)
        imageView.image = UIImage.init(named: "Bristle Grass.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        view.addSubview(imageView)
        
        let backgroundEffectView = UIVisualEffectView.init(frame: view.frame)
        backgroundEffectView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        backgroundEffectView.effect = UIBlurEffect.init(style: .dark)
        view.addSubview(backgroundEffectView)
        
        //label1
        labelEffectView1 = UIVisualEffectView.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: 80))
        view.addSubview(labelEffectView1)
        
        let contentLabel1 = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: view.frame.width - 20, height: 80))
        contentLabel1.numberOfLines = 0
        contentLabel1.textColor = UIColor.red
        contentLabel1.font = .systemFont(ofSize: 17, weight: .semibold)
        contentLabel1.text = "UIVibrancyEffect amplifies and adjusts the color of content layered behind the view, allowing content placed inside the contentView to become more vivid. It is intended to be placed over, or as a subview of, a UIVisualEffectView that has been configured with a UIBlurEffect. This effect only affects content added to the contentView. Because the vibrancy effect is color dependent, subviews added to the contentView need to be tintColorDidChange aware and must be prepared to update themselves accordingly. UIImageView will need its image to have a rendering mode of UIImageRenderingModeAlwaysTemplate to receive the proper effect."
        labelEffectView1.contentView.addSubview(contentLabel1)
        
        //label2
        labelEffectView2 = UIVisualEffectView.init(frame: CGRect.init(x: 0, y: labelEffectView1.frame.maxY + 10, width: view.frame.width, height: 80))
        view.addSubview(labelEffectView2)
        
        let contentLabel2 = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: view.frame.width - 20, height: 80))
        contentLabel2.numberOfLines = 0
        contentLabel2.textColor = UIColor.red
        contentLabel2.font = UIFont.systemFont(ofSize: 13)
        contentLabel2.text = "UIVibrancyEffect amplifies and adjusts the color of content layered behind the view, allowing content placed inside the contentView to become more vivid. It is intended to be placed over, or as a subview of, a UIVisualEffectView that has been configured with a UIBlurEffect. This effect only affects content added to the contentView. Because the vibrancy effect is color dependent, subviews added to the contentView need to be tintColorDidChange aware and must be prepared to update themselves accordingly. UIImageView will need its image to have a rendering mode of UIImageRenderingModeAlwaysTemplate to receive the proper effect."
        labelEffectView2.contentView.addSubview(contentLabel2)
        
        //image1
        imageEffectView1 = UIVisualEffectView.init(frame: CGRect.init(x: 0, y: labelEffectView2.frame.maxY + 20, width: 100, height: 100))
        view.addSubview(imageEffectView1)
        
        let contentImageView1 = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        contentImageView1.image = UIImage.init(named: "Frog.jpg")?.withRenderingMode(.alwaysTemplate)
        imageEffectView1.contentView.addSubview(contentImageView1)
        
        //image2
        imageEffectView2 = UIVisualEffectView.init(frame: CGRect.init(x: imageEffectView1.frame.maxX + 20, y: imageEffectView1.frame.minY, width: view.frame.width - (imageEffectView1.frame.maxX + 20), height: 100))
        view.addSubview(imageEffectView2)
        
        let contentImageView2 = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: imageEffectView2.frame.width, height: imageEffectView2.frame.height))
        contentImageView2.image = UIImage.init(named: "Grass Blades.jpg")?.withRenderingMode(.alwaysTemplate)
        imageEffectView2.contentView.addSubview(contentImageView2)
        
        
        //separator
        separatorEffectView1 = UIVisualEffectView.init(frame: CGRect.init(x: 0, y: imageEffectView2.frame.maxY + 20, width: view.frame.width, height: 50))
        view.addSubview(separatorEffectView1)
        
        let separatorView1 = UIView.init(frame: CGRect.init(x: 10, y: 0, width: view.frame.width - 20, height: 50))
        separatorView1.backgroundColor = .gray
        separatorEffectView1.contentView.addSubview(separatorView1)
        
        //segmentedControl
        let segmentedControl = UISegmentedControl.init(items: ["None","Use Vibrancy"])
        segmentedControl.frame = CGRect.init(x: 10, y: separatorEffectView1.frame.maxY + 30, width: view.frame.maxX - 20, height: 30)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(segmented:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 1
        view.addSubview(segmentedControl)
        
        let styleSegmentedControl = UISegmentedControl.init(items: ["ExtraLight","Light","Dark"])
        styleSegmentedControl.frame = CGRect.init(x: 10, y: segmentedControl.frame.maxY + 10, width: view.frame.maxX - 20, height: 30)
        styleSegmentedControl.selectedSegmentIndex = 2
        styleSegmentedControl.addTarget(self, action: #selector(styleSegmentedControlValueChanged(segmented:)), for: .valueChanged)
        view.addSubview(styleSegmentedControl)
        
        updateContentViewBlurEffect()
    }

    @objc func segmentedControlValueChanged(segmented:UISegmentedControl) {
        useVibrancy = segmented.selectedSegmentIndex == 1
        updateContentViewBlurEffect()
    }
    
    @objc func styleSegmentedControlValueChanged(segmented:UISegmentedControl) {
        effectStyle = UIBlurEffect.Style(rawValue: segmented.selectedSegmentIndex)
        updateContentViewBlurEffect()
    }
    
    func updateContentViewBlurEffect(){
        let blurEffect = UIBlurEffect.init(style: effectStyle)
        
        if (useVibrancy) {
            let labelEffect1 = UIVibrancyEffect.init(blurEffect: blurEffect, style: .label)
            labelEffectView1.effect = labelEffect1
            
            let labelEffect2 = UIVibrancyEffect.init(blurEffect: blurEffect, style: .secondaryLabel)
            labelEffectView2.effect = labelEffect2
            
            let imageEffect1 = UIVibrancyEffect.init(blurEffect: blurEffect, style: .fill)
            imageEffectView1.effect = imageEffect1
            
            let imageEffect2 = UIVibrancyEffect.init(blurEffect: blurEffect, style: .secondaryFill)
            imageEffectView2.effect = imageEffect2
            
            let separatorEffect = UIVibrancyEffect.init(blurEffect: blurEffect, style: .separator)
            separatorEffectView1.effect = separatorEffect
            
        }else{
            labelEffectView1.effect = blurEffect
            labelEffectView2.effect = blurEffect
            imageEffectView1.effect = blurEffect
            imageEffectView2.effect = blurEffect
            separatorEffectView1.effect = blurEffect
        }
    }
}
