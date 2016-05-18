//
//  YEActionsheetViewController.m
//  YEActionsheet
//
//  Created by yangyunen on 16/4/7.
//  Copyright © 2016年 yangyunen. All rights reserved.
//

#import "YEActionsheetStyle1.h"

///屏幕尺寸
#define SC_WIDTH [UIScreen mainScreen].bounds.size.width
#define SC_HEIGHT [UIScreen mainScreen].bounds.size.height
///每个按钮的高度
#define BUTTON_HEIGHT 40
///不同组按钮之间的距离
#define BUTTON_MARGIN 5
///每个按钮的高度
#define BUTTON_LINEHEIGHT 1

@interface YEActionsheetStyle1 ()

@property (strong, nonnull) UIView *dropView;

@end

@implementation YEActionsheetStyle1


///初始化方法，根据数据源的按钮属性初始化
- (instancetype)initWithNameArray:(NSArray *)names colorArray:(NSArray *)colors andEnable:(NSArray *)enables
{
    self = [super init];
    NSAssert(names.count == enables.count || names.count == colors.count, @"item count in name array should equal to statu array and color array");
    
    self = [super init];
    
    self.nameArray = names;
    self.colorArray = colors;
    self.enableArray = enables;
    
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///载入自定义actionsheet
    [self loadMyView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///视图载入方法
- (void)loadMyView
{
    UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, SC_HEIGHT - ((self.nameArray.count + 1) * BUTTON_HEIGHT + BUTTON_MARGIN + (self.nameArray.count - 1) * BUTTON_LINEHEIGHT), SC_WIDTH, (self.nameArray.count + 1) * BUTTON_HEIGHT + BUTTON_MARGIN + (self.nameArray.count - 1) * BUTTON_LINEHEIGHT)];
    
    containerView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    
    [self.view addSubview:containerView];
    
    for (int i = 0; i < self.nameArray.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, i * (BUTTON_HEIGHT + BUTTON_LINEHEIGHT), SC_WIDTH, BUTTON_HEIGHT)];
        [button setTitle:self.nameArray[i] forState:UIControlStateNormal];
        if ([self.enableArray[i] isEqual:@NO]) {
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }else{
            [button setTitleColor:self.colorArray[i] forState:UIControlStateNormal];
        }
        button.backgroundColor = [UIColor whiteColor];
        button.tag = i;
        
        [button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        
        [containerView addSubview:button];
        
        //如果当前不是最后一个button就添加一条分割线
        if (i != self.nameArray.count - 1) {
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, i * BUTTON_LINEHEIGHT + (i +1) * BUTTON_HEIGHT, SC_WIDTH, BUTTON_HEIGHT)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [containerView addSubview:lineView];
        }
    }
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, containerView.bounds.size.height - BUTTON_HEIGHT, SC_WIDTH, BUTTON_HEIGHT)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [containerView addSubview:cancelButton];
    cancelButton.backgroundColor = [UIColor whiteColor];
    cancelButton.tag = -1;
    [cancelButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    
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
    _dropView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - ((_nameArray.count * BUTTON_HEIGHT) + BUTTON_HEIGHT + BUTTON_MARGIN));
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _dropView.frame = CGRectMake(SC_WIDTH / 2, SC_HEIGHT / 2, 0, 0);
}
- (void)hideActionController {
    self.view.backgroundColor = [UIColor clearColor];
    __weak typeof(self)wself = self;
    [wself dismissViewControllerAnimated:YES completion:nil];
}

//调用代理类的代理方法，将点击结果的处理委托给代理
- (void)clickItem:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [self hideActionController];
    int buttonTag = (int)button.tag;
    if (buttonTag != -1 && [self.enableArray[buttonTag] isEqual:@YES]) {
        [_delegate didClickNumber:self.oriButtonNumber andItem:sender];
    }
}

@end
