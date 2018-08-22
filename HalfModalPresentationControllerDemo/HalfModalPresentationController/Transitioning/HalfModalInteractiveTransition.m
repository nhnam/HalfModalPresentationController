//
//  HalfModalInteractiveTransition.m
//  Ring
//
//  Created by Nam Nguyen on 8/22/18.
//  Copyright © 2018 RMD Operations Pte. Ltd. All rights reserved.
//

#import "HalfModalInteractiveTransition.h"

@implementation HalfModalInteractiveTransition
-(instancetype) initWithViewController:(UIViewController *)viewController withView:(UIView *)view presentingViewController:(UIViewController *)presentingViewController {
    if(self = [super init]) {
        self.viewController = viewController;
        self.presentingViewController = presentingViewController;
        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        [self.panGestureRecognizer addTarget:self action:@selector(onPan:)];
        [view addGestureRecognizer:self.panGestureRecognizer];
    }
    return self;
}

-(void)onPan:(UIPanGestureRecognizer*)pan {
    CGPoint translation = [pan translationInView: pan.view.superview];
    switch(pan.state) {
        case UIGestureRecognizerStateBegan: {
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height - 50;
            CGFloat dragAmount = screenHeight;
            CGFloat threshold = 0.2;
            CGFloat percent = translation.y / dragAmount;
            percent = fmax(percent, 0.0);
            percent = fmin(percent, 1.0);
            [self updateInteractiveTransition:percent];
            self.shouldComplete = percent > threshold;
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            if((pan.state == UIGestureRecognizerStateCancelled) && self.shouldComplete == NO) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
        }
            break;
        default:
            [self cancelInteractiveTransition];
            break;
    }
}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    [super startInteractiveTransition:transitionContext];
}

- (CGFloat)completionSpeed {
    return 1.0 - self.percentComplete;
}

@end
