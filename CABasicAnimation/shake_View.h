//
//  shake_View.h
//  CABasicAnimation
//
//  Created by 余晋龙 on 2017/3/27.
//  Copyright © 2017年 余晋龙. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^Shake_ViewBeganShakeBlock)();
typedef void (^Shake_ViewStopShakeBlock)();
typedef void (^Shake_ViewDeleteShakeBlock)();
/**抖动按钮*/
@interface shake_View : UIView
@property(nonatomic , copy) Shake_ViewBeganShakeBlock beganShakeBlock;
@property(nonatomic , copy) Shake_ViewStopShakeBlock stopShakeBlock;
@property(nonatomic , copy) Shake_ViewDeleteShakeBlock deleteShakeBlock;
@end
