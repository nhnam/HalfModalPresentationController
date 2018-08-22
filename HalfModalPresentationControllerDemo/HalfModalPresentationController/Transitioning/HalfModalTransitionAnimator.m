//
//  HalfModalTransitionAnimator.m
//  Ring
//
//  Created by Nam Nguyen on 8/22/18.
//  Copyright © 2018 RMD Operations Pte. Ltd. All rights reserved.
//

#import "HalfModalTransitionAnimator.h"

@implementation HalfModalTransitionAnimator

- (instancetype) initWithType:(HalfModalTransitionAnimatorType)type {
    if(self = [super init]) {
        self.type = type;
    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *to = [transitionContext viewControllerForKey: UITransitionContextToViewControllerKey];
    UIViewController *from = [transitionContext viewControllerForKey: UITransitionContextFromViewControllerKey];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        CGRect frame = from.view.frame;
        frame.origin.y = 800;
        from.view.frame = frame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:(!transitionContext.transitionWasCancelled)];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}

@end
