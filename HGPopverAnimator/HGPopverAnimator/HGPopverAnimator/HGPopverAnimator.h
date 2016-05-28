//
//  HGTransitioningDelegate.h
//  自定义转场动画_OC
//
//  Created by 查昊 on 16/5/23.
//  Copyright © 2016年 haocha. All rights reserved.
//

#import "HGPopverAnimatorDelegate.h"
typedef NS_ENUM(NSInteger,HGPopverAnimatorStyle)
{
    
    HGPopverAnimatorCustomStyle= 0,         //自定义样式
///////////////参照UIWinow///////////////
    HGPopverAnimatorFromLeftStyle,          //从左边弹出样式
    HGPopverAnimatorFromRightStyle,         //从右边弹出样式
    HGPopverAnimatorFromTopStyle,           //从顶部弹出样式
    HGPopverAnimatorFromBottomStyle,        //从底部弹出样式
    
///////////////参照PresentView///////////
    HGPopverAnimatorHiddenStyle,            //显示隐藏样式
    HGPopverAnimatorVerticalScaleStyle,     //垂直压缩样式
    HGPopverAnimatorHorizontalScaleStyle,   //水平压缩样式
    HGPopverAnimatorFocusTopCenterStyle,    //顶部中点消失样式
    HGPopverAnimatorFocusTopLeftStyle,      //顶部左上角消失样式
    HGPopverAnimatorFocusTopRightStyle,     //顶部右上角消失样式
};

NS_ASSUME_NONNULL_BEGIN
@interface HGPopverAnimator : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new  NS_UNAVAILABLE;
/**
 *  构造方法
 *
 *  @param animateStyle    动画类型
 *  @param relateView      参照的view,目前没用,设置nil即可
 *  @param presentFrame    弹出视图的frame
 *  @param backgroundColor 背景色
 *  @param delegate        代理
 *  @param animated        是否动画
 */
- (instancetype)initWithAnimateStyle:(HGPopverAnimatorStyle)animateStyle relateView:(nullable UIView *)relateView presentFrame:(CGRect)presentFrame backgroundColor:(nullable UIColor *)backgroundColor delegate:(nullable id <HGPopverAnimatorDelegate>)delegate animated:(BOOL)animated;

@end
NS_ASSUME_NONNULL_END




