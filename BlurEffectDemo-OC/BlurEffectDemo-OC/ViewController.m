//
//  ViewController.m
//  BlurEffectDemo-OC
//
//  Created by Fourfire on 2020/9/2.
//  Copyright © 2020 DurianFourfire. All rights reserved.
//

#import "ViewController.h"
#import "BlurEffectViewController.h"
#import "VibrancyEffectViewController.h"
#import "CustomBlurEffectViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *menuArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"UIVisualEffectView";
    [self.view addSubview:self.tableView];
    
    [self performSelector:@selector(thankYouForYourSupport) withObject:nil afterDelay:60];
}


- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;;
}

- (NSArray *)menuArray
{
    if (_menuArray == nil) {
        _menuArray = @[@"UIVisualEffectView + UIBlurEffect",@"UIVisualEffectView + UIVibrancyEffect",@"UIVisualEffectView + UICustomBlurEffect"];
    }
    return _menuArray;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = self.menuArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    switch (indexPath.row) {
        case 0:
        {
            BlurEffectViewController *vc = [[BlurEffectViewController alloc] init];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        case 1:
        {
            VibrancyEffectViewController *vc = [[VibrancyEffectViewController alloc] init];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        case 2:
        {
            CustomBlurEffectViewController *vc = [[CustomBlurEffectViewController alloc] init];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        default:
            break;
    }
}


- (void)thankYouForYourSupport
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"🌟感谢支持🌟" message:@"如果觉得内容对你有帮助，不妨给我一颗小星星吧，非常感谢～" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我偏不" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:cancelAction];
    [alertVC addAction:sureAction];
    [self.navigationController presentViewController:alertVC animated:true completion:nil];
}



@end
