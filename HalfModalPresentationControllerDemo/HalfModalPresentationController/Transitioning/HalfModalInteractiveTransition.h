//
//  HalfModalInteractiveTransition.h
//  Ring
//
//  Created by Nam Nguyen on 8/22/18.
//  Copyright © 2018 RMD Operations Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HalfModalInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) UIViewController *presentingViewController;
@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (assign, nonatomic) BOOL shouldComplete;
- (instancetype) initWithViewController:(UIViewController*)viewController withView:(UIView*)view presentingViewController:(UIViewController*)presentingViewController;
@end
