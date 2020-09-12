//
//  BlurEffectViewController.m
//  BlurEffectDemo-OC
//
//  Created by Fourfire on 2020/9/4.
//  Copyright © 2020 DurianFourfire. All rights reserved.
//

#import "BlurEffectViewController.h"

@interface BlurEffectViewController ()

@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;


@end

@implementation BlurEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    self.navigationItem.title = @"UIVisualEffectView + UIBlurEffect";
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView.image = [UIImage imageNamed:@"Bristle Grass.jpg"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = true;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:imageView];
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithFrame:imageView.frame];
    effectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:effectView];
    _effectView = effectView;
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    _effectView.effect = blurEffect;
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"None",@"ExtraLight",@"Light",@"Dark"]];
    [segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    segmentedControl.selectedSegmentIndex = 3;
    _segmentedControl = segmentedControl;
}


- (void)viewWillLayoutSubviews
{
    _segmentedControl.frame = CGRectMake(10, CGRectGetMaxY(self.view.frame) - 50 - self.view.safeAreaInsets.bottom, CGRectGetMaxX(self.view.frame) - 20, 30);
}


- (void)segmentedControlValueChanged:(UISegmentedControl *)segmented
{
    UIBlurEffectStyle effectStyle = segmented.selectedSegmentIndex - 1;
    if (effectStyle >= 0) {
        _effectView.hidden = false;
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:effectStyle];
        _effectView.effect = blurEffect;
    }else{
        _effectView.hidden = true;
    }
}

@end
