//
//  UIViewController+HalfModalPresentable.m
//  Ring
//
//  Created by Nam Nguyen on 8/22/18.
//  Copyright © 2018 RMD Operations Pte. Ltd. All rights reserved.
//

#import "UIViewController+HalfModalPresentable.h"
#import "HalfModalPresentationController.h"

@implementation UIViewController(HalfModalPresentable)

- (void)maximizeToFullScreen {
    if(!self.navigationController) {
        return;
    }
    if(!self.navigationController.presentationController) {
        return;
    }
    if(![self.navigationController.presentationController isKindOfClass:[HalfModalPresentationController class]]) {
        return;
    }
    HalfModalPresentationController *presentation = (HalfModalPresentationController *)self.navigationController.presentationController;
    [presentation changeScale:ModalScaleStateAdjustedOnce];
}

- (BOOL)isHalfModalMaximized {
    // Only for UINavigationController
    return NO;
}
@end
