//
//  FCXDotLineAnimationRefreshHeaderView.m
//  FCXAnimation
//
//  Created by fcx on 2019/9/11.
//  Copyright © 2019 fcx. All rights reserved.
//

#import "FCXDotLineAnimationRefreshHeaderView.h"
#import "FCXDotLinePathAnimation.h"

@implementation FCXDotLineAnimationRefreshHeaderView
{
    FCXDotLinePathAnimation *_animationView;
}

- (void)addRefreshContentView {
    _animationView = [[FCXDotLinePathAnimation alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 55, self.frame.size.width, 55)];
    [self addSubview:_animationView];
    
    __weak FCXDotLinePathAnimation *weakAnimationView = _animationView;
    __weak typeof(self) weakSelf = self;
    self.pullingPercentHandler = ^(CGFloat pullingPercent) {
        weakAnimationView.progress = pullingPercent;
        if (weakSelf.progressHandler) {
            weakSelf.progressHandler(pullingPercent);
        }
    };
}

- (void)fcxChangeToStatusLoading {
    [super fcxChangeToStatusLoading];
    [_animationView startAnimating];
}

- (void)fcxChangeToStatusNormal {
    [super fcxChangeToStatusNormal];
    [_animationView stopAnimating];
}

@end
