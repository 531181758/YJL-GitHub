//
//  shake_View.m
//  CABasicAnimation
//
//  Created by 余晋龙 on 2017/3/27.
//  Copyright © 2017年 余晋龙. All rights reserved.
//

#import "shake_View.h"

@implementation shake_View
{
    UIButton *bt;  //左上角的小按钮
    BOOL ifClickBt; //是否点击  默认NO
    int i;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
        self.userInteractionEnabled = YES;
        self.layer.cornerRadius = 10;
        //添加手势
        UILongPressGestureRecognizer *recognize = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress)];
        //长按响应时间
        recognize.minimumPressDuration = 1;
        [self addGestureRecognizer:recognize];
        [self addButton];
    }
    return self;
}
-(void)addButton{
    //
    bt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
    bt.center = self.frame.origin;
    bt.layer.cornerRadius = 15 / 2;
    bt.backgroundColor = [UIColor blackColor];
    [bt setTitle:@"❌" forState:0];
    bt.titleLabel.font = [UIFont systemFontOfSize:10];
    [bt setTitleColor:[UIColor whiteColor] forState:0];
    [bt addTarget:self action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bt];
    bt.hidden = YES;
}
#pragma mark============长按手势=======
-(void)longPress{
    i += 1;
    ifClickBt = !ifClickBt;
    CAKeyframeAnimation *animation = (CAKeyframeAnimation *)[self.layer animationForKey:@"shakeAnimation"];
    if (ifClickBt){  //点击了  需要抖动
        bt.hidden = NO;  //显示
        if (animation == nil){  //
            [self shakeImage];   //====
        }else{
            [self resume];   //===开始抖动
        }
        if (_beganShakeBlock) {   //开始抖动后调用block
            _beganShakeBlock();
        }
    }else{    //处于抖动状态  但不想删除  要停止抖动
        if (i == 4) {
            if (animation){
                [self pause]; //==停止
            }
        }
    }
}
#pragma mark==========点击删除小图标=====
-(void)clickDeleteButton:(UIButton *)sender{
    //
    [self removeFromSuperview];  //删除
    if (_deleteShakeBlock) {
        _deleteShakeBlock();
    }
    
}
- (void)pause {    // 停止
    i = 0;
    self.layer.speed = 0.0;
    bt.hidden = YES;  // 隐藏
    if (_stopShakeBlock) {    //停止抖动后调用block
        _stopShakeBlock();
    }
}
- (void)resume {   //开始
    self.layer.speed = 1.0;
}
-(void)shakeImage{
    //
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    //在这里@"transform.rotation"==@"transform.rotation.z"
    NSValue *value1 = [NSNumber numberWithFloat:-M_PI/180*4];
    NSValue *value2 = [NSNumber numberWithFloat:M_PI/180*4];
    NSValue *value3 = [NSNumber numberWithFloat:-M_PI/180*4];
    anima.values = @[value1,value2,value3];
    anima.repeatCount = MAXFLOAT;  // 次数为不限
    //anima.duration = 0.25;
    //恢复原样
    //anima.autoreverses = YES;

    anima.fillMode = kCAFillModeForwards;
    anima.removedOnCompletion = NO;
    [self.layer addAnimation:anima forKey:@"shakeAnimation"];
}

@end
