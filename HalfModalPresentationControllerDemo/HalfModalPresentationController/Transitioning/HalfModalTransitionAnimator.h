//
//  HalfModalTransitionAnimator.h
//  Ring
//
//  Created by Nam Nguyen on 8/22/18.
//  Copyright © 2018 RMD Operations Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HalfModalTransitionAnimatorTypePresent,
    HalfModalTransitionAnimatorTypeDismiss
}HalfModalTransitionAnimatorType;

@interface HalfModalTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>
@property(assign, nonatomic) HalfModalTransitionAnimatorType type;
- (instancetype)initWithType:(HalfModalTransitionAnimatorType)type;
@end
