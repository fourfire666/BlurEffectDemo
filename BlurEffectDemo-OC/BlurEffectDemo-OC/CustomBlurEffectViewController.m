//
//  CustomBlurEffectViewController.m
//  BlurEffectDemo-OC
//
//  Created by Fourfire on 2020/9/4.
//  Copyright © 2020 DurianFourfire. All rights reserved.
//

#import "CustomBlurEffectViewController.h"
#import "UIKitUtils.h"

@interface CustomBlurEffectViewController ()

@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UILabel *blurRadiusLabel;

@end

@implementation CustomBlurEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    self.navigationItem.title = @"UIVisualEffectView + UICustomBlurEffect";

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView.image = [UIImage imageNamed:@"Bristle Grass.jpg"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = true;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:imageView];
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithFrame:imageView.frame];
    effectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [imageView addSubview:effectView];
    _effectView = effectView;
    
    _effectView.effect = makeCustomZoomBlurEffect();
    
    _slider = ({
        UISlider *slider = [[UISlider alloc] init];
        slider.maximumValue = 50.f;
        slider.minimumValue = 0.f;
        slider.value = 10.f;
        [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:slider];
        slider;
    });
    
    UILabel *blurRadiusLabel = [[UILabel alloc] init];
    blurRadiusLabel.adjustsFontSizeToFitWidth = true;
    [self.view addSubview:blurRadiusLabel];
    _blurRadiusLabel = blurRadiusLabel;
    
    [self sliderValueChanged:_slider];
}


- (void)viewWillLayoutSubviews
{
    _blurRadiusLabel.frame = CGRectMake(10, CGRectGetMaxY(self.view.frame) - 50 - self.view.safeAreaInsets.bottom, 100, 30);
    _slider.frame = CGRectMake(CGRectGetMaxX(_blurRadiusLabel.frame) + 10, CGRectGetMinY(_blurRadiusLabel.frame), CGRectGetMaxX(self.view.frame) - CGRectGetMaxX(_blurRadiusLabel.frame) - 20, 30);
}


- (void)sliderValueChanged:(UISlider *)slider
{
    _blurRadiusLabel.text = [NSString stringWithFormat:@"BlurRadius:%.1f",slider.value];
    _effectView.effect = makeCustomZoomBlurEffectWithRadius(slider.value);
}


@end
