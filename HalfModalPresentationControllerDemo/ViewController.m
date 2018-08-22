//
//  ViewController.m
//  HalfModalPresentationControllerDemo
//
//  Created by Nam Nguyen on 8/22/18.
//  Copyright © 2018 Nam Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+HalfModalPresentable.h"
#import "UINavigationController+HalfModalPresentable.h"
#import "HalfModalTransitioningDelegate.h"

@interface ViewController ()
@property (strong, nonatomic) HalfModalTransitioningDelegate *halfModalTransitioningDelegate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.halfModalTransitioningDelegate = [[HalfModalTransitioningDelegate alloc] initWithViewController:self presentingViewController:segue.destinationViewController];
    segue.destinationViewController.modalPresentationStyle = UIModalPresentationCustom;
    segue.destinationViewController.transitioningDelegate = self.halfModalTransitioningDelegate;
}


@end
