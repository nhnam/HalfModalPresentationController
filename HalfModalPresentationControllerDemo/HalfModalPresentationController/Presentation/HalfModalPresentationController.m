//
//  HalfModalPresentationController.m
//  Ring
//
//  Created by Nam Nguyen on 8/22/18.
//  Copyright © 2018 RMD Operations Pte. Ltd. All rights reserved.
//

#import "HalfModalPresentationController.h"

@interface HalfModalPresentationController()
@property (strong, nonatomic) UIView* dimmingView;
@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (assign, nonatomic) CGFloat direction;
@property (assign, nonatomic) ModalScaleState state;
@end

@implementation HalfModalPresentationController
-(instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        self.isMaximied = NO;
        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        [self.panGestureRecognizer addTarget:self action:@selector(onPan:)];
        [presentedViewController.view addGestureRecognizer:self.panGestureRecognizer];
    }
    return self;
}

-(UIView*)dimmingView {
    if(_dimmingView) {
        return _dimmingView;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.containerView.bounds.size.width, self.containerView.bounds.size.height)];
    
    // Blur Effect
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = view.frame;
    [view addSubview:blurEffectView];
    
    // Vibrancy Effect
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    vibrancyEffectView.frame = view.frame;
    
    // Add the vibrancy view to the blur view
    [blurEffectView.contentView addSubview:vibrancyEffectView];
    
    _dimmingView = view;
    return view;
}

-(void)onPan:(UIPanGestureRecognizer*)pan {
    CGPoint endPoint = [pan translationInView:pan.view.superview];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            CGRect frame = self.presentedView.frame;
            frame.size.height = self.containerView.frame.size.height;
            self.presentedView.frame = frame;
        }
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint velocity = [pan velocityInView: pan.view.superview];
            
            switch(self.state) {
                case ModalScaleStateNormal: {
                    CGRect frame = self.presentedView.frame;
                    frame.origin.y = endPoint.y + self.containerView.frame.size.height/2;
                    self.presentedView.frame = frame;
                }
                    break;
                case ModalScaleStateAdjustedOnce: {
                    CGRect frame = self.presentedView.frame;
                    frame.origin.y = endPoint.y;
                    self.presentedView.frame = frame;
                }
                    break;
            }
            self.direction = velocity.y;
        }
            break;
        case UIGestureRecognizerStateEnded: {
            if(self.direction < 0) {
                [self changeScale:ModalScaleStateAdjustedOnce];
            } else {
                if (self.state == ModalScaleStateAdjustedOnce) {
                    [self changeScale:ModalScaleStateNormal];
                } else {
                    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
                }
            }
        }
            break;
        default:
            break;
    }
}

- (void)changeScale:(ModalScaleState)newState {
    if(!self.presentedView) {
        return;
    }
    
    if(!self.containerView) {
        return;
    }
    UIView *presentedView = self.presentedView;
    UIView *containerView = self.containerView;
    
    [UIView animateWithDuration:0.8 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        presentedView.frame = containerView.frame;
        
        CGRect containerFrame = containerView.frame;
        CGRect halfFrame = CGRectMake(0, containerFrame.size.height/2, containerFrame.size.width, containerFrame.size.height/2);
        CGRect frame = (newState == ModalScaleStateAdjustedOnce) ? containerView.frame : halfFrame;
        
        presentedView.frame = frame;
        
        if([self.presentedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navController = (UINavigationController*)self.presentedViewController;
            self.isMaximied = YES;
            [navController setNeedsStatusBarAppearanceUpdate];
            
            // Force the navigation bar to update its size
            [navController setNavigationBarHidden:YES];
            [navController setNavigationBarHidden:NO];
        }
    } completion:^(BOOL finished) {
        self.state = newState;
    }];
}

- (CGRect) frameOfPresentedViewInContainerView {
    return CGRectMake(0, self.containerView.bounds.size.height/2, self.containerView.bounds.size.width, self.containerView.bounds.size.height/2);
}

- (void)presentationTransitionWillBegin {
    if(!self.containerView) {
        return;
    }
    if(!self.presentingViewController.transitionCoordinator) {
        return;
    }
    UIView *containerView = self.containerView;
    id <UIViewControllerTransitionCoordinator> coordinator = self.presentingViewController.transitionCoordinator;
    
    UIView *dimmedView = self.dimmingView;
    dimmedView.alpha = 0.0;
    [containerView addSubview: dimmedView];
    [dimmedView addSubview: self.presentedViewController.view];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        dimmedView.alpha = 1.0;
        self.presentingViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
    }];
}

- (void) dismissalTransitionWillBegin {
    if(!self.presentingViewController.transitionCoordinator) {
        return;
    }
    id <UIViewControllerTransitionCoordinator> coordinator = self.presentingViewController.transitionCoordinator;
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.0;
        self.presentingViewController.view.transform = CGAffineTransformIdentity;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
    }];
}

- (void) dismissalTransitionDidEnd:(BOOL)completed {
    if(!completed) {
        return;
    }
    [self.dimmingView removeFromSuperview];
    _dimmingView = nil;
    self.isMaximied = NO;
}
@end
