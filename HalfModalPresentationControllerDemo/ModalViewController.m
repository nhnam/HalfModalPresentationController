//
//  ModalViewController.m
//  HalfModalPresentationControllerDemo
//
//  Created by Nam Nguyen on 8/22/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

#import "ModalViewController.h"
#import "UIViewController+HalfModalPresentable.h"
#import "HalfModalTransitioningDelegate.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didTouchDismiss:(id)sender {
    if([self.navigationController.transitioningDelegate isKindOfClass:[HalfModalTransitioningDelegate class]]) {
        ((HalfModalTransitioningDelegate*)self.navigationController.transitioningDelegate).interactiveDismiss = NO;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
