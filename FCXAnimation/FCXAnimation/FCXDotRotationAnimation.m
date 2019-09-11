//
//  FCXDotRotationAnimation.m
//  FCXAnimation
//
//  Created by fcx on 2019/9/11.
//  Copyright © 2019 fcx. All rights reserved.
//

#import "FCXDotRotationAnimation.h"

CGFloat const FCXDTAnimationContentHeight = 40.0;
CGFloat const FCXDTAnimationRadius = 5.0;
CGFloat const FCXDTAnimationTranslateDistance = 5.0;

@implementation FCXDotRotationAnimation
{
    CALayer *_bgLayer;
    CAShapeLayer *_topLayer;
    CAShapeLayer *_bottomLayer;
    CAShapeLayer *_leftLayer;
    CAShapeLayer *_rightLayer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addContentLayer];
    }
    return self;
}

- (void)addContentLayer {
    _bgLayer = [CALayer layer];
    _bgLayer.frame = CGRectMake((self.frame.size.width - FCXDTAnimationContentHeight)/2.0, (self.frame.size.height - FCXDTAnimationContentHeight)/2.0, FCXDTAnimationContentHeight, FCXDTAnimationContentHeight);
    [self.layer addSublayer:_bgLayer];
    
    UIColor *topPointColor = [UIColor colorWithRed:90 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1.0];
    UIColor *leftPointColor = [UIColor colorWithRed:250 / 255.0 green:85 / 255.0 blue:78 / 255.0 alpha:1.0];
    UIColor *bottomPointColor = [UIColor colorWithRed:92 / 255.0 green:201 / 255.0 blue:105 / 255.0 alpha:1.0];
    UIColor *rightPointColor = [UIColor colorWithRed:253 / 255.0 green:175 / 255.0 blue:75 / 255.0 alpha:1.0];
    CGFloat dotSize = FCXDTAnimationRadius * 2;
    
    _topLayer = [self addDotLayerWithFrame:CGRectMake(_bgLayer.frame.size.width/2.0 - FCXDTAnimationRadius, 0, dotSize, dotSize) color:topPointColor.CGColor];
    _leftLayer = [self addDotLayerWithFrame:CGRectMake(0, _bgLayer.frame.size.height/2.0 - FCXDTAnimationRadius, dotSize, dotSize) color:leftPointColor.CGColor];
    _bottomLayer = [self addDotLayerWithFrame:CGRectMake(_bgLayer.frame.size.width/2.0 - FCXDTAnimationRadius, _bgLayer.frame.size.height - dotSize, dotSize, dotSize) color:bottomPointColor.CGColor];
    _rightLayer = [self addDotLayerWithFrame:CGRectMake(_bgLayer.frame.size.width - dotSize,  _bgLayer.frame.size.height/2.0 - FCXDTAnimationRadius, dotSize, dotSize) color:rightPointColor.CGColor];
}

- (CAShapeLayer *)addDotLayerWithFrame:(CGRect)frame color:(CGColorRef)color {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = frame;
    layer.fillColor = color;
    layer.path = [UIBezierPath bezierPathWithOvalInRect:layer.bounds].CGPath;
    [_bgLayer addSublayer:layer];
    return layer;
}

- (void)startAnimating {
    [self addTranslationAnimationToLayer:_topLayer xValue:0 yValue:FCXDTAnimationTranslateDistance];
    [self addTranslationAnimationToLayer:_leftLayer xValue:FCXDTAnimationTranslateDistance yValue:0];
    [self addTranslationAnimationToLayer:_bottomLayer xValue:0 yValue:-FCXDTAnimationTranslateDistance];
    [self addTranslationAnimationToLayer:_rightLayer xValue:-FCXDTAnimationTranslateDistance yValue:0];
    [self addRotationAniToLayer:_bgLayer];
}

- (void)stopAnimating {
    [_topLayer removeAllAnimations];
    [_leftLayer removeAllAnimations];
    [_bottomLayer removeAllAnimations];
    [_rightLayer removeAllAnimations];
    [_bgLayer removeAllAnimations];
}

- (void)addTranslationAnimationToLayer:(CALayer *)layer xValue:(CGFloat)x yValue:(CGFloat)y {
    CAKeyframeAnimation * translationKeyframeAni = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    translationKeyframeAni.duration = 1.0;
    translationKeyframeAni.repeatCount = HUGE;
    translationKeyframeAni.removedOnCompletion = NO;
    translationKeyframeAni.fillMode = kCAFillModeForwards;
    translationKeyframeAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    NSValue * fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0.f)];
    NSValue * toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(x, y, 0.f)];
    translationKeyframeAni.values = @[fromValue, toValue, fromValue, toValue, fromValue];
    [layer addAnimation:translationKeyframeAni forKey:@"FCXTranslationAnimation"];
}

- (void)addRotationAniToLayer:(CALayer *)layer {
    CABasicAnimation * rotationAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAni.fromValue = @(0);
    rotationAni.toValue = @(M_PI * 2);
    rotationAni.duration = 1.0;
    rotationAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotationAni.repeatCount = HUGE;
    rotationAni.fillMode = kCAFillModeForwards;
    rotationAni.removedOnCompletion = NO;
    [layer addAnimation:rotationAni forKey:@"FCXDotAnimation"];
}

- (void)dealloc {
    [self stopAnimating];
}

@end
