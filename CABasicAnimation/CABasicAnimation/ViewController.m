//
//  ViewController.m
//  CABasicAnimation
//
//  Created by 余晋龙 on 2017/3/27.
//  Copyright © 2017年 余晋龙. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
//
#import "shake_View.h"

@interface ViewController ()

@end

@implementation ViewController
{
    //
    shake_View *v1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addShakeButton];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    v.layer.cornerRadius = 50;
    v.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:v];
    
    
    //=============================================================
    
    
    
    
    
#if 0
    
    
    //
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position"];
    anima.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)];
    anima.toValue = [NSValue valueWithCGRect:CGRectMake(0, 300, 100, 100)];
    anima.duration = 2.0;
    //如果fillMode=kCAFillModeForwards和removedOnComletion=NO，那么在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
    anima.fillMode = kCAFillModeForwards;
    anima.removedOnCompletion = NO;
    [v.layer addAnimation:anima forKey:@"positionAnimation"];
    
    dispatch_time_t myTime = dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC); //相对时间   10秒
    dispatch_after(myTime, dispatch_get_main_queue(), ^{
        
        NSLog(@"被延迟了1秒");
        
    });
#endif
    
    
#if 1
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //这个方法根据传入的rect矩形参数绘制一个内切曲线
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2-100, 200, 200)];
    anima.path = path.CGPath;
    anima.duration = 2.0f;
    [v.layer addAnimation:anima forKey:@"pathAnimation"];
    
#endif
}

-(void)addShakeButton{
    //
    if (!v1) {
        v1 = [[shake_View alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        v1.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
        v1.beganShakeBlock = ^(){
            NSLog(@"开始抖动了");
        };
        v1.stopShakeBlock = ^(){
            NSLog(@"停止了");
        };
        v1.deleteShakeBlock = ^(){
            NSLog(@"删除了");
        };
    }
    
    [self.view addSubview:v1];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //跳转到下个页面
    NextViewController *nextVC = [[NextViewController alloc]init];
    [self presentViewController:nextVC animated:YES completion:^{
        NSLog(@"+++++");
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //
    // Dispose of any resources that can be recreated.
}


@end
