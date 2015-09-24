//
//  ViewController.m
//  Whisper-LoadingAnimation
//
//  Created by 劉雲志 on 15/9/23.
//  Copyright (c) 2015年 Lyz. All rights reserved.
//

#import "ViewController.h"

#define ScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)


@interface ViewController (){
    UIBezierPath *_logoPath;
}

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) CAShapeLayer *logoLayer;

@property (nonatomic, strong) CAShapeLayer *logoBackgroundLayer;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setupBackgroundView];
    [self setupBackgroundLayer];
}

- (void)setupBackgroundView{
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.75;
    _backgroundView.center = self.view.center;
    _backgroundView.layer.cornerRadius = 10;
    [self.view addSubview:_backgroundView];
}

- (void)setupBackgroundLayer{
    _logoBackgroundLayer = [CAShapeLayer layer];
    _logoBackgroundLayer.lineCap = kCALineCapRound;
    _logoBackgroundLayer.lineJoin = kCALineJoinRound;
    _logoBackgroundLayer.strokeColor = [UIColor whiteColor].CGColor;
    _logoBackgroundLayer.lineWidth = 8;
    _logoBackgroundLayer.opacity = 0.75;

    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat startX = 20;
    CGFloat startY = 30;
    CGFloat ratio = 3;
    
    [path moveToPoint:CGPointMake(startX, startY)];
    [path addLineToPoint:CGPointMake(startX+2.5*ratio,startY+4.33*ratio)];
    
    [path moveToPoint:CGPointMake(startX+5*ratio, startY+8.66*ratio)];
    [path addLineToPoint:CGPointMake(startX+10*ratio,startY)];
    
    [path moveToPoint:CGPointMake(startX+10*ratio,startY)];
    [path addLineToPoint:CGPointMake(startX+12.5*ratio, startY+4.33*ratio)];
    
    [path moveToPoint:CGPointMake(startX+15*ratio, startY+8.66*ratio)];
    [path addLineToPoint:CGPointMake(startX+20*ratio, startY)];
    _logoPath = path;
    _logoBackgroundLayer.path = path.CGPath;
    [_backgroundView.layer addSublayer:_logoBackgroundLayer];
}

- (void)setupLogoLayer{
    _logoLayer = [CAShapeLayer layer];
    _logoLayer.lineCap = kCALineCapRound;
    _logoLayer.lineJoin = kCALineJoinRound;
    _logoLayer.strokeColor = [UIColor purpleColor].CGColor;
    _logoLayer.lineWidth = 8;
    _logoLayer.opacity = 0.75;
    _logoLayer.path = _logoPath.CGPath;
    [_backgroundView.layer addSublayer:_logoLayer];
}

- (void)startStrokeAnimation{
    [self removeAllSublayerAndAnimations];
    
    [self setupLogoLayer];
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"strokeEnd";
    anim.fromValue = @0;
    anim.toValue = @1;
    anim.repeatCount = MAXFLOAT;
    anim.duration = 1;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_logoLayer addAnimation:anim forKey:nil];
}

- (void)startStrokeTwoAnimation{
    [self removeAllSublayerAndAnimations];

    [self setupLogoLayer];
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"strokeEnd";
    anim.fromValue = @0;
    anim.toValue = @1.2;
    CABasicAnimation *anim2 = [CABasicAnimation animation];
    anim2.keyPath = @"strokeStart";
    anim2.fromValue = @(-0.2);
    anim2.toValue = @1;
    CAAnimationGroup *animGroup = [CAAnimationGroup new];
    animGroup.animations = @[anim,anim2];
    animGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animGroup.repeatCount = MAXFLOAT;
    animGroup.duration = 3;
    animGroup.autoreverses = YES;
    [_logoLayer addAnimation:animGroup forKey:nil];
}

- (void)startKeyFrameAnimation{
    [self removeAllSublayerAndAnimations];
    
    CALayer *pointLayer = [CALayer layer];
    pointLayer.frame = CGRectMake(20, 30, 8, 8);
    pointLayer.cornerRadius = 4;
    pointLayer.backgroundColor = [UIColor purpleColor].CGColor;
    pointLayer.masksToBounds = YES;
    pointLayer.opacity = 0.75;
    [_backgroundView.layer addSublayer:pointLayer];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.keyPath = @"position";
    anim.path = _logoPath.CGPath;
    anim.duration = 3;
    anim.autoreverses = YES;
    anim.repeatCount = MAXFLOAT;
    [pointLayer addAnimation:anim forKey:nil];
}

- (void)startReplicaAnimation{
    [self removeAllSublayerAndAnimations];
    
    CAReplicatorLayer *reLayer = [CAReplicatorLayer layer];
    reLayer.frame = _backgroundView.bounds;
    reLayer.backgroundColor = [UIColor clearColor].CGColor;
    [_backgroundView.layer addSublayer:reLayer];
    reLayer.instanceCount = 5;
    reLayer.instanceDelay = 0.3;
    reLayer.instanceAlphaOffset = -0.2;
    
    CALayer *pointLayer = [CALayer layer];
    pointLayer.frame = CGRectMake(20, 30, 8, 8);
    pointLayer.cornerRadius = 4;
    pointLayer.masksToBounds = YES;
    pointLayer.backgroundColor = [UIColor purpleColor].CGColor;
    pointLayer.opacity = 0.75;
    pointLayer.cornerRadius = 4;
    [reLayer addSublayer:pointLayer];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.keyPath = @"position";
    anim.path = _logoPath.CGPath;
    anim.duration = 5;
    anim.autoreverses = YES;
    anim.repeatCount = MAXFLOAT;
    [pointLayer addAnimation:anim forKey:nil];
}

- (void)removeAllSublayerAndAnimations{
    [_logoBackgroundLayer.sublayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperlayer];
    }];
    [_backgroundView.layer.sublayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx>=1) [obj removeFromSuperlayer];
    }];
    [_logoLayer removeAllAnimations];
    _logoLayer = nil;
}

- (IBAction)stroke:(id)sender {
    [self startStrokeAnimation];
}
- (IBAction)strokeTwo:(id)sender {
    [self startStrokeTwoAnimation];
}
- (IBAction)keyFrame:(id)sender {
    [self startKeyFrameAnimation];
}
- (IBAction)replicator:(id)sender {
    [self startReplicaAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
