//
//  YEActionsheetViewController.h
//  YEActionsheet
//
//  Created by yangyunen on 16/4/7.
//  Copyright © 2016年 yangyunen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YEActionsheetStyle2Delegate

- (void)didClickButtonNumber:(int)buttonNumber andSubButtonNumber:(int)subButtonNumber;

@end

@interface YEActionsheetStyle2 : UIViewController

@property (strong, nonatomic) NSArray *nameArray;
@property (strong, nonatomic) NSArray *colorArray;

@property int oriButtonNumber;

@property (nonatomic, weak) id delegate;

- (instancetype)initWithNameArray:(NSArray *)names colorArray:(NSArray *)colors;

@end
