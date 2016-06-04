//
//  UIViewController+HGTransition.m
//  HGTransitionAnimator
//
//  Created by 查昊 on 16/5/25.
//  Copyright © 2016年 haocha. All rights reserved.
//

#import "UIViewController+HGAnimator.h"
#import "HGTransitionAnimator.h"
#import <objc/runtime.h>


static NSString * const HGTransitionAnimatorKey=@"HGTransitionAnimatorKey";

@implementation UIViewController (HGAnimator)

-(HGTransitionAnimator *)hg_presentViewController:(UIViewController *)viewControllerToPresent
                                     animateStyle:(HGTransitionAnimatorStyle)style
                                         delegate:(id<HGTransitionAnimatorDelegate>)delegate
                                     presentFrame:(CGRect)presentFrame
                                  backgroundColor:(UIColor *)backgroundColor
                                         animated:(BOOL)flag
{
    UIView* relateView=self.view;
    HGTransitionAnimator *animator=[[HGTransitionAnimator alloc]initWithAnimateStyle:style relateView:relateView  presentFrame:presentFrame backgroundColor:backgroundColor delegate:delegate animated:flag];
    
    objc_setAssociatedObject(self, &HGTransitionAnimatorKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &HGTransitionAnimatorKey, animator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    viewControllerToPresent.modalPresentationStyle=UIModalPresentationCustom;
    viewControllerToPresent.transitioningDelegate=animator;
    void (^presentBlock)(void) = ^ (void) {
        [self presentViewController:viewControllerToPresent animated:YES completion:nil];
    };
    dispatch_main_async_safe(presentBlock);
    
    return  animator;
}

- (void)hg_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    HGTransitionAnimator *animator=(HGTransitionAnimator *)self.transitioningDelegate;
    if (!flag) [animator transitionDuration:0];
    void (^dismissBlock)(void) = ^ (void) {
        [self dismissViewControllerAnimated:flag completion:completion];
    };
    dispatch_main_async_safe(dismissBlock);
    objc_setAssociatedObject([self currentPresentingViewController], &HGTransitionAnimatorKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HGPresentationController *)hg_getPresentationController
{
    HGTransitionAnimator *animator=(HGTransitionAnimator *)self.transitioningDelegate;
    NSAssert1([animator isKindOfClass:[HGTransitionAnimator class]], @"负责转场的对象不是HGTransitionAnimator或它的子类%@,获取失败!",animator);
    return [animator getPresentationController];
}
- (UIViewController *)currentPresentingViewController
{
    if ([self.presentingViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav=(UINavigationController *)self.presentingViewController;
        return  [nav.viewControllers lastObject];;
    }
    return  self.presentingViewController;
}
@end



