//
//  FCXSimpleAnimationController.m
//  FCXAnimation
//
//  Created by fcx on 2019/9/11.
//  Copyright © 2019 fcx. All rights reserved.
//

#import "FCXSimpleAnimationController.h"
#import "FCXDotRotationAnimation.h"

@interface FCXSimpleAnimationController ()
{
    FCXDotRotationAnimation *_animatinonView;
}

@end

@implementation FCXSimpleAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupAnimation:(NSDictionary *)info {
    self.title = info[@"title"];
    NSString *className = info[@"animationClass"];
    if (!className) {
        NSLog(@"不存在的动画类型");
        return;
    }
    Class cls = NSClassFromString(className);
    if (!cls) {
        NSLog(@"找不到动画的类");
        return;
    }
    _animatinonView = [[cls alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, self.view.frame.size.width - 40)];
    [self.view addSubview:_animatinonView];
    [_animatinonView startAnimating];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"停止动画" forState:UIControlStateNormal];
    [btn setTitle:@"开始动画" forState:UIControlStateSelected];
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        btn.frame = CGRectMake(0, self.view.frame.size.height - 50 - 20 - mainWindow.safeAreaInsets.bottom, self.view.frame.size.width, 50);
    } else {
        btn.frame = CGRectMake(0, self.view.frame.size.height - 50 - 20, self.view.frame.size.width, 50);
    }
    [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:btn];
}

- (void)buttonAction:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        [_animatinonView stopAnimating];
    } else {
        [_animatinonView startAnimating];
    }
}

@end
