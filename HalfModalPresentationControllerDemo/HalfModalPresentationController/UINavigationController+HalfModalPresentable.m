//
//  UINavigationController+HalfModalPresentable.m
//  Ring
//
//  Created by Nam Nguyen on 8/22/18.
//  Copyright © 2018 RMD Operations Pte. Ltd. All rights reserved.
//

#import "UINavigationController+HalfModalPresentable.h"
#import "UIViewController+HalfModalPresentable.h"
#import "HalfModalPresentationController.h"

@implementation UINavigationController(HalfModalPresentable)

-(void)maximizeToFullScreen {
    return [super maximizeToFullScreen];
}

-(BOOL)isHalfModalMaximized {
    if(!self.presentationController) {
        return NO;
    }
    if(![self.presentationController isKindOfClass:[HalfModalPresentationController class]]) {
        return NO;
    }
    HalfModalPresentationController *presentation = (HalfModalPresentationController*)self.presentationController;
    return presentation.isMaximied;
}
@end
