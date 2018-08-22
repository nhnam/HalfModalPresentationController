//
//  HalfModalTransitioningDelegate.h
//  Ring
//
//  Created by Nam Nguyen on 8/22/18.
//  Copyright © 2018 RMD Operations Pte. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HalfModalInteractiveTransition.h"

@interface HalfModalTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>
@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) UIViewController *presentingViewController;
@property (strong, nonatomic) HalfModalInteractiveTransition *interactionController;
@property (assign, nonatomic) BOOL interactiveDismiss;
-(instancetype)initWithViewController:(UIViewController*) viewController presentingViewController:(UIViewController*)presentingViewController;
@end
