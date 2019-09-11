//
//  FCXDotLinePathAnimation.h
//  FCXAnimation
//
//  Created by fcx on 2019/9/11.
//  Copyright © 2019 fcx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FCXDotLinePathAnimation : UIView

@property (nonatomic, assign) CGFloat progress;

- (void)startAnimating;
- (void)stopAnimating;

@end

NS_ASSUME_NONNULL_END
