//
//  VibrancyEffectViewController.m
//  BlurEffectDemo-OC
//
//  Created by Fourfire on 2020/9/4.
//  Copyright © 2020 DurianFourfire. All rights reserved.
//

#import "VibrancyEffectViewController.h"

@interface VibrancyEffectViewController ()

@property (nonatomic, strong) UIVisualEffectView *labelEffectView;
@property (nonatomic, strong) UIVisualEffectView *labelEffectView2;

@property (nonatomic, strong) UIVisualEffectView *imageEffectView;
@property (nonatomic, strong) UIVisualEffectView *imageEffectView2;

@property (nonatomic, strong) UIVisualEffectView *separatorEffectView1;

@property (nonatomic, assign) bool useVibrancy;
@property (nonatomic, assign) UIBlurEffectStyle effectStyle;

@end

@implementation VibrancyEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    self.navigationItem.title = @"UIVisualEffectView + UIVibrancyEffect";
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView.image = [UIImage imageNamed:@"Bristle Grass.jpg"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = true;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:imageView];
    
    UIVisualEffectView *backEffectView = [[UIVisualEffectView alloc] initWithFrame:self.view.frame];
    backEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    backEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:backEffectView];
    
    //label 1
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    [self.view addSubview:effectView];
    _labelEffectView = effectView;
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 80)];
    contentLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    contentLabel.text = @"UIVibrancyEffect amplifies and adjusts the color of content layered behind the view, allowing content placed inside the contentView to become more vivid. It is intended to be placed over, or as a subview of, a UIVisualEffectView that has been configured with a UIBlurEffect. This effect only affects content added to the contentView. Because the vibrancy effect is color dependent, subviews added to the contentView need to be tintColorDidChange aware and must be prepared to update themselves accordingly. UIImageView will need its image to have a rendering mode of UIImageRenderingModeAlwaysTemplate to receive the proper effect.";
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor redColor];
    [effectView.contentView addSubview:contentLabel];
    
    
    //label 2
    UIVisualEffectView *labelEffectView2 = [[UIVisualEffectView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(effectView.frame) + 10, self.view.frame.size.width, 80)];
    [self.view addSubview:labelEffectView2];
    _labelEffectView2 = labelEffectView2;
    
    UILabel *contentLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 80)];
    contentLabel2.font = [UIFont systemFontOfSize:13];
    contentLabel2.text = @"UIVibrancyEffect amplifies and adjusts the color of content layered behind the view, allowing content placed inside the contentView to become more vivid. It is intended to be placed over, or as a subview of, a UIVisualEffectView that has been configured with a UIBlurEffect. This effect only affects content added to the contentView. Because the vibrancy effect is color dependent, subviews added to the contentView need to be tintColorDidChange aware and must be prepared to update themselves accordingly. UIImageView will need its image to have a rendering mode of UIImageRenderingModeAlwaysTemplate to receive the proper effect.";
    contentLabel2.numberOfLines = 0;
    contentLabel2.textColor = [UIColor redColor];
    [labelEffectView2.contentView addSubview:contentLabel2];
    
    
    //image 1
    UIVisualEffectView *imageEffectView = [[UIVisualEffectView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(labelEffectView2.frame) + 20, 100, 100)];
    [self.view addSubview:imageEffectView];
    _imageEffectView = imageEffectView;
    
    UIImageView *contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    contentImageView.image = [[UIImage imageNamed:@"Frog.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [imageEffectView.contentView addSubview:contentImageView];
    
    //image 2
    UIVisualEffectView *imageEffectView2 = [[UIVisualEffectView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageEffectView.frame) + 20, imageEffectView.frame.origin.y, self.view.frame.size.width - CGRectGetMaxX(imageEffectView.frame), 100)];
    [self.view addSubview:imageEffectView2];
    _imageEffectView2 = imageEffectView2;
    
    UIImageView *contentImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageEffectView2.frame.size.width, 100)];
    contentImageView2.image = [[UIImage imageNamed:@"Grass Blades.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [imageEffectView2.contentView addSubview:contentImageView2];
    
    //separator 1
    UIVisualEffectView *separatorEffectView1 = [[UIVisualEffectView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageEffectView2.frame) + 20, self.view.frame.size.width, 50)];
    [self.view addSubview:separatorEffectView1];
    _separatorEffectView1 = separatorEffectView1;
    UIView *separatorView1 = [[UIView alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(separatorEffectView1.frame) - 20, 50)];
    separatorView1.backgroundColor = [UIColor grayColor];
    [separatorEffectView1.contentView addSubview:separatorView1];
    
    //segmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"None",@"Use Vibrancy"]];
    [segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.frame = CGRectMake(10,CGRectGetMaxY(separatorEffectView1.frame) + 30, self.view.frame.size.width - 20, 30);
    segmentedControl.selectedSegmentIndex = 1;
    [self.view addSubview:segmentedControl];
    
    UISegmentedControl *effectStyleSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"ExtraLight",@"Light",@"Dark"]];
    [effectStyleSegmentedControl addTarget:self action:@selector(effectStyleSegmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    effectStyleSegmentedControl.frame = CGRectMake(10, CGRectGetMaxY(segmentedControl.frame) + 10, self.view.frame.size.width - 20, 30);
    effectStyleSegmentedControl.selectedSegmentIndex = 2;
    [self.view addSubview:effectStyleSegmentedControl];
    
    _useVibrancy = true;
    _effectStyle = UIBlurEffectStyleDark;
    [self updateContentViewBlurEffect];
}

- (void)segmentedControlValueChanged:(UISegmentedControl *)segmented
{
    _useVibrancy = segmented.selectedSegmentIndex == 1;
    [self updateContentViewBlurEffect];
}


- (void)effectStyleSegmentedControlValueChanged:(UISegmentedControl *)segmented
{
    _effectStyle = segmented.selectedSegmentIndex;
    [self updateContentViewBlurEffect];
}

- (void)updateContentViewBlurEffect
{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:_effectStyle];
    if (_useVibrancy) {
        UIVibrancyEffect *labelEffect1 = [UIVibrancyEffect effectForBlurEffect:blurEffect style:UIVibrancyEffectStyleLabel];
        _labelEffectView.effect = labelEffect1;
        
        UIVibrancyEffect *labelEffect2 = [UIVibrancyEffect effectForBlurEffect:blurEffect style:UIVibrancyEffectStyleSecondaryLabel];
        _labelEffectView2.effect = labelEffect2;
        
        UIVibrancyEffect *imageEffect1 = [UIVibrancyEffect effectForBlurEffect:blurEffect style:UIVibrancyEffectStyleFill];
        _imageEffectView.effect = imageEffect1;
        
        UIVibrancyEffect *imageEffect2 = [UIVibrancyEffect effectForBlurEffect:blurEffect style:UIVibrancyEffectStyleSecondaryFill];
        _imageEffectView2.effect = imageEffect2;
        
        UIVibrancyEffect *separatorEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect style:UIVibrancyEffectStyleSeparator];
        _separatorEffectView1.effect = separatorEffect;
        
    }else{
        _labelEffectView.effect = blurEffect;
        _labelEffectView2.effect = blurEffect;
        _imageEffectView.effect = blurEffect;
        _imageEffectView2.effect = blurEffect;
        _separatorEffectView1.effect = blurEffect;
    }
}


@end
