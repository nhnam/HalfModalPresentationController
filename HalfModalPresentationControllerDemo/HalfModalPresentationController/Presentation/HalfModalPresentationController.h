//
//  HalfModalPresentationController.h
//  Ring
//
//  Created by Nam Nguyen on 8/22/18.
//  Copyright © 2018 RMD Operations Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ModalScaleStateNormal,
    ModalScaleStateAdjustedOnce,
} ModalScaleState;

@interface HalfModalPresentationController : UIPresentationController
@property (assign, nonatomic) BOOL isMaximied;
- (void)changeScale:(ModalScaleState)newState;
@end
