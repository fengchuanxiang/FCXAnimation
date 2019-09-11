//
//  FCXDotLineAnimationRefreshHeaderView.h
//  FCXAnimation
//
//  Created by fcx on 2019/9/11.
//  Copyright © 2019 fcx. All rights reserved.
//

#import "FCXRefreshHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FCXDotLineAnimationRefreshHeaderView : FCXRefreshHeaderView

@property (nonatomic, copy) FCXPullingPercentHandler progressHandler;//!<刷新的相应事件

@end

NS_ASSUME_NONNULL_END
