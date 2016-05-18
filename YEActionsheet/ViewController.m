//
//  ViewController.m
//  YEActionsheet
//
//  Created by yangyunen on 16/4/7.
//  Copyright © 2016年 yangyunen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *textColorArray;
@property (nonatomic, strong) NSArray *enableArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //数据源设置各个按钮
    self.nameArray = @[@"男", @"女", @"其他"];
    self.textColorArray = @[[UIColor blackColor], [UIColor blackColor], [UIColor blackColor]];
    self.enableArray = @[@YES, @YES, @NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickStyle1:(UIButton *)sender {
    
    YEActionsheetStyle1 *YA = [[YEActionsheetStyle1 alloc]initWithNameArray:self.nameArray colorArray:self.textColorArray andEnable:self.enableArray];
    
    YA.delegate = self;
    
    [YA setOriButtonNumber:0];
    
    [self presentViewController:YA animated:YES completion:^{
        
    }];
}

- (IBAction)clickStyle2:(UIButton *)sender {
    YEActionsheetStyle2 *YA2 = [[YEActionsheetStyle2 alloc]initWithNameArray:self.nameArray colorArray:self.textColorArray];
    
    YA2.delegate = self;
    
    [YA2 setOriButtonNumber:1];
    
    [self presentViewController:YA2 animated:YES completion:^{
        
    }];
}

//delegate获取用户选择了那个按钮
- (void)didClickNumber:(int)number andItem:(id)sender
{
    
}
- (void)didClickButtonNumber:(int)buttonNumber andSubButtonNumber:(int)subButtonNumber
{
    
}

@end
