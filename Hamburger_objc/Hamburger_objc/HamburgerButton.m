//
//  HamburgerButton.m
//  Hamburger_objc
//
//  Created by guojunyi on 1/16/15.
//  Copyright (c) 2015 ___guojunyi___. All rights reserved.
//

#import "HamburgerButton.h"
@interface CALayer(Expand)

@end

@implementation CALayer(Expand)
-(void)ocb_applyAnimation:(CABasicAnimation*)animation{
    CABasicAnimation *copy = [animation copy];
    
    if (copy.fromValue == nil) {
        
        copy.fromValue = [self.presentationLayer valueForKeyPath:copy.keyPath];
    }
    
    [self addAnimation:copy forKey:copy.keyPath];
    [self setValue:copy.toValue forKeyPath:copy.keyPath];
}
@end

@interface HamburgerButton()
@property (nonatomic,strong) CAShapeLayer *top;
@property (nonatomic,strong) CAShapeLayer *middle;
@property (nonatomic,strong) CAShapeLayer *bottom;
@end

@implementation HamburgerButton
@synthesize isShowMenu = _isShowMenu;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.top = [[CAShapeLayer alloc] init];
        self.middle = [[CAShapeLayer alloc] init];
        self.bottom = [[CAShapeLayer alloc] init];
        
        self.top.path = [self shortStroke];
        self.middle.path = [self outline];
        self.bottom.path = [self shortStroke];
        
        
        self.top.fillColor = nil;
        self.top.strokeColor = [[UIColor whiteColor] CGColor];
        self.top.lineWidth = 4;
        self.top.miterLimit = 4;
        self.top.lineCap = kCALineCapRound;
        self.top.masksToBounds = true;
        CGPathRef strokingPath1 = CGPathCreateCopyByStrokingPath(self.top.path, nil, 4, kCGLineCapRound, kCGLineJoinMiter, 4);
        self.top.bounds = CGPathGetPathBoundingBox(strokingPath1);
        
        
        
        
        
        self.middle.fillColor = nil;
        self.middle.strokeColor = [[UIColor whiteColor] CGColor];
        self.middle.lineWidth = 4;
        self.middle.miterLimit = 4;
        self.middle.lineCap = kCALineCapRound;
        self.middle.masksToBounds = false;
        CGPathRef strokingPath2 = CGPathCreateCopyByStrokingPath(self.middle.path, nil, 4, kCGLineCapRound, kCGLineJoinMiter, 4);
        self.middle.bounds = CGPathGetPathBoundingBox(strokingPath2);
        
        self.bottom.fillColor = nil;
        self.bottom.strokeColor = [[UIColor whiteColor] CGColor];
        self.bottom.lineWidth = 4;
        self.bottom.miterLimit = 4;
        self.bottom.lineCap = kCALineCapRound;
        self.bottom.masksToBounds = true;
        CGPathRef strokingPath3 = CGPathCreateCopyByStrokingPath(self.bottom.path, nil, 4, kCGLineCapRound, kCGLineJoinMiter, 4);
        self.bottom.bounds = CGPathGetPathBoundingBox(strokingPath3);
        
        
        [self.layer addSublayer:self.middle];
        [self.layer addSublayer:self.top];
        [self.layer addSublayer:self.bottom];
        
        
        
        
        CGFloat hamburgerStrokeStart = 0.028;
        CGFloat hamburgerStrokeEnd = 0.111;
        
        self.top.anchorPoint = CGPointMake(28.0 / 30.0, 0.5);
        self.top.position = CGPointMake(40, 18);
        
        self.middle.position = CGPointMake(27, 27);
        self.middle.strokeStart = hamburgerStrokeStart;
        self.middle.strokeEnd = hamburgerStrokeEnd;
        
        self.bottom.anchorPoint = CGPointMake(28.0 / 30.0, 0.5);
        self.bottom.position = CGPointMake(40, 36);
    }
    return self;
}

-(CGMutablePathRef)shortStroke{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 2, 2);
    CGPathAddLineToPoint(path, nil, 28, 2);
    return path;
}


-(CGMutablePathRef)outline{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 10, 27);
    CGPathAddCurveToPoint(path, nil, 12.00, 27.00, 28.02, 27.00, 40, 27);
    CGPathAddCurveToPoint(path, nil, 55.92, 27.00, 50.47,  2.00, 27,  2);
    CGPathAddCurveToPoint(path, nil, 13.16,  2.00,  2.00, 13.16,  2, 27);
    CGPathAddCurveToPoint(path, nil,  2.00, 40.84, 13.16, 52.00, 27, 52);
    CGPathAddCurveToPoint(path, nil, 40.84, 52.00, 52.00, 40.84, 52, 27);
    CGPathAddCurveToPoint(path, nil, 52.00, 13.16, 42.39,  2.00, 27,  2);
    CGPathAddCurveToPoint(path, nil, 13.16,  2.00,  2.00, 13.16,  2, 27);
    return path;
}

-(void)setIsShowMenu:(BOOL)isShowMenu{
    _isShowMenu = isShowMenu;
    CABasicAnimation *strokeStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    CABasicAnimation *strokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    CGFloat menuStrokeStart = 0.325;
    CGFloat menuStrokeEnd = 0.9;
    CGFloat hamburgerStrokeStart = 0.028;
    CGFloat hamburgerStrokeEnd = 0.111;
    
    if(_isShowMenu){
        
        strokeStart.toValue = [NSNumber numberWithFloat:menuStrokeStart];
        strokeStart.duration = 0.5;
        strokeStart.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :-0.4 :0.5 :1];
        
        
        strokeEnd.toValue = [NSNumber numberWithFloat:menuStrokeEnd];
        strokeEnd.duration = 0.6;
        strokeEnd.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :-0.4 :0.5 :1];
    }else{
        strokeStart.toValue = [NSNumber numberWithFloat:hamburgerStrokeStart];
        strokeStart.duration = 0.5;
        strokeStart.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :0 :0.5 :1.2];
        strokeStart.beginTime = CACurrentMediaTime() + 0.1;
        strokeStart.fillMode = kCAFillModeBackwards;
        
        strokeEnd.toValue = [NSNumber numberWithFloat:hamburgerStrokeEnd];
        strokeEnd.duration = 0.6;
        strokeEnd.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :0.3 :0.5 :0.9];
        
    }
    
    [self.middle ocb_applyAnimation:strokeStart];
    [self.middle ocb_applyAnimation:strokeEnd];
    
    CABasicAnimation *topTransform = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    topTransform.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5 :-0.8 :0.5 :1.85];
    
    topTransform.duration = 0.4;
    topTransform.fillMode = kCAFillModeBackwards;
    
    
    CABasicAnimation *bottomTransform = [topTransform copy];
    
    
    if(_isShowMenu){
        
        CATransform3D translation = CATransform3DMakeTranslation(-4, 0, 0);
        topTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(translation, -0.7853975, 0, 0, 1)];
        topTransform.beginTime = CACurrentMediaTime() + 0.25;
        
        bottomTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(translation, 0.7853975, 0, 0, 1)];
        
        bottomTransform.beginTime = CACurrentMediaTime() + 0.25;
    } else {
        topTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        topTransform.beginTime = CACurrentMediaTime() + 0.05;
        
        bottomTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        bottomTransform.beginTime = CACurrentMediaTime() + 0.05;
    }
    
    [self.top ocb_applyAnimation:topTransform];
    [self.bottom ocb_applyAnimation:bottomTransform];
    
}


@end
