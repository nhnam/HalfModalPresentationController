//
//  HalfModalTransitioningDelegate.m
//  Ring
//
//  Created by Nam Nguyen on 8/22/18.
//  Copyright © 2018 RMD Operations Pte. Ltd. All rights reserved.
//

#import "HalfModalTransitioningDelegate.h"
#import "HalfModalTransitionAnimator.h"
#import "HalfModalPresentationController.h"

@implementation HalfModalTransitioningDelegate
-(instancetype)initWithViewController:(UIViewController *)viewController presentingViewController:(UIViewController *)presentingViewController {
    if(self = [super init]) {
        self.viewController = viewController;
        self.presentingViewController = presentingViewController;
        self.interactionController = [[HalfModalInteractiveTransition alloc] initWithViewController:self.viewController withView:self.presentingViewController.view presentingViewController:self.presentingViewController];
        self.interactiveDismiss = YES;
    }
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[HalfModalTransitionAnimator alloc] initWithType:HalfModalTransitionAnimatorTypeDismiss];
}

- (UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[HalfModalPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    if(self.interactiveDismiss) {
        return self.interactionController;
    }
    return nil;
}
@end
