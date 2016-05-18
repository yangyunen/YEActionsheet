//
//  YEActionsheetViewController.m
//  YEActionsheet
//
//  Created by yangyunen on 16/4/7.
//  Copyright © 2016年 yangyunen. All rights reserved.
//

#import "YEActionsheetStyle2.h"

#define SC_WIDTH [UIScreen mainScreen].bounds.size.width
#define SC_HEIGHT [UIScreen mainScreen].bounds.size.height
#define BUTTON_HEIGHT 40
#define BUTTON_MARGIN 5
#define BUTTON_LINEHEIGHT 1

@interface YEActionsheetStyle2 ()

@property (strong, nonnull) UIView *dropView;
@property (strong, nonnull) UIView *containerView;
@property (strong, nonnull) UILabel *textLabel;

@property int number;

@end

@implementation YEActionsheetStyle2

- (instancetype)initWithNameArray:(NSArray *)names colorArray:(NSArray *)colors
{
    self = [super init];
    NSAssert(names.count == colors.count, @"item count in name array should equal to statu array and color array");
    
    self = [super init];
    
    self.nameArray = names;
    self.colorArray = colors;
    
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.view.backgroundColor = [UIColor clearColor];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.number = (int)self.nameArray.count / 2;
    
    [self loadMyView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMyView
{
    ///弹出的按钮的容器
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(0, SC_HEIGHT - 2 * BUTTON_HEIGHT - 5, SC_WIDTH, 2 * BUTTON_HEIGHT +5)];
    self.containerView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    [self.view addSubview:self.containerView];
    
    ///选项区域的容器，通过通过容器添加背景颜色
    UIView *textBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SC_WIDTH, BUTTON_HEIGHT)];
    textBackgroundView.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:textBackgroundView];
    
    ///展示每个选项的label
    self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake((SC_WIDTH - SC_WIDTH / 4) / 2, 0, SC_WIDTH / 4, BUTTON_HEIGHT)];
    self.textLabel.text = self.nameArray[self.number];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [textBackgroundView addSubview:self.textLabel];
    ///确认设置按钮
    UIButton *doneButton = [[UIButton alloc]initWithFrame:CGRectMake((SC_WIDTH - SC_WIDTH / 4) / 2, 0, SC_WIDTH / 4, BUTTON_HEIGHT)];
    [doneButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [textBackgroundView addSubview:doneButton];
    
    ///调节选项按钮
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake((SC_WIDTH - SC_WIDTH / 4) / 2 + SC_WIDTH / 4, 0, BUTTON_HEIGHT / 2, BUTTON_HEIGHT / 2)];
    addButton.tag = 9301;
    [addButton setImage:[UIImage imageNamed:@"jiantou1"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(adjustObject:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *subButton = [[UIButton alloc]initWithFrame:CGRectMake((SC_WIDTH - SC_WIDTH / 4) / 2 + SC_WIDTH / 4, BUTTON_HEIGHT / 2, BUTTON_HEIGHT / 2, BUTTON_HEIGHT / 2)];
    subButton.tag = 9302;
    [subButton setImage:[UIImage imageNamed:@"jiantou2"] forState:UIControlStateNormal];
    [subButton addTarget:self action:@selector(adjustObject:) forControlEvents:UIControlEventTouchUpInside];
    [textBackgroundView addSubview:addButton];
    [textBackgroundView addSubview:subButton];
    
    ///取消设置按钮
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.containerView.bounds.size.height - BUTTON_HEIGHT, SC_WIDTH, BUTTON_HEIGHT)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.containerView addSubview:cancelButton];
    cancelButton.backgroundColor = [UIColor whiteColor];
    cancelButton.tag = -1;
    [cancelButton addTarget:self action:@selector(adjustObject:) forControlEvents:UIControlEventTouchUpInside];
    
    ///对弹出按钮外的区域添加一个遮罩蒙板
    [self.view addSubview:({
        _dropView = [[UIView alloc] initWithFrame:CGRectZero];
        _dropView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        _dropView;
    })];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self hideActionController];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    ///通过弹出按钮的尺寸和屏幕储存来设置遮罩蒙板的尺寸
    _dropView.frame = CGRectMake(0, 0, SC_WIDTH, SC_HEIGHT - self.containerView.bounds.size.height);
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    _dropView.frame = CGRectZero;
}

- (void)hideActionController {
    
    self.view.backgroundColor = [UIColor clearColor];
    
    __weak typeof(self)wself = self;
        
    [wself dismissViewControllerAnimated:YES completion:nil];
}

- (void)adjustObject:(id)sender
{
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case 9302:
            if (self.number > 0) {
                self.number--;
            }
            break;
        case 9301:
            if (self.number < self.nameArray.count - 1) {
                self.number++;
            }
            break;
        case -1:
            [self hideActionController];
        default:
            break;
    }
    self.textLabel.text = self.nameArray[self.number];
}

- (void)done:(id)sender
{
    [self hideActionController];
    [_delegate didClickButtonNumber:self.oriButtonNumber andSubButtonNumber:self.number];
}

@end
