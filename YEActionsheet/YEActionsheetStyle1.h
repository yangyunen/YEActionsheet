//
//  YEActionsheetViewController.h
//  YEActionsheet
//
//  Created by yangyunen on 16/4/7.
//  Copyright © 2016年 yangyunen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YEActionsheetStyle1Delegate

- (void)didClickNumber:(int)number andItem:(id)sender;

@end

@interface YEActionsheetStyle1 : UIViewController

@property (strong, nonatomic) NSArray *nameArray;
@property (strong, nonatomic) NSArray *colorArray;
@property (strong, nonatomic) NSArray *enableArray;

@property int oriButtonNumber;

@property (nonatomic, weak) id delegate;

- (instancetype)initWithNameArray:(NSArray *)names colorArray:(NSArray *)colors andEnable:(NSArray *)enables;

@end
