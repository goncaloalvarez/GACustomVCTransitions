//
//  GATransitionAnimatorBuilder.m
//  GACustomTransitions
//
//  Created by Gonçalo Alvarez on 05/02/16.
//  Copyright © 2016 GoncaloAlvarez. All rights reserved.
//

#import "GAAnimatedTransitionAnimatorBuilder.h"
#import "GAAnimatedTransitionAnimator_Protected.h"
#import "GAAnimatedTransitionAnimator.h"

@interface GAAnimatedTransitionAnimatorBuilder ()

@property (nonatomic, weak)UIViewController *fromViewController;
@property (nonatomic, weak)UIViewController *toViewController;

@property (nonatomic, assign)GATransitionContextType transitionContextType;
@property (nonatomic, weak) id <GAAnimatedTransitionDelegate> transitionDelegate;

@end

@implementation GAAnimatedTransitionAnimatorBuilder

#pragma mark - Lifecycle

- (instancetype)initWithFromViewController:(UIViewController *)fromViewController
                          toViewController:(UIViewController *)toViewController
                        transitionDelegate:(id<GAAnimatedTransitionDelegate>)transitionDelegate {

    self = [super init];
    
    if (self) {
    
        _fromViewController = fromViewController;
        _toViewController = toViewController;
        _transitionDelegate = transitionDelegate;
    }
    
    return self;
}

#pragma mark - Public

- (GAAnimatedTransitionAnimatorBuilder *)configureTransitionContextType:(GATransitionContextType)transitionContextType {

    self.transitionContextType = transitionContextType;
    return self;
}

- (GAAnimatedTransitionAnimator *)build {

    GAAnimatedTransitionAnimator *animator = [GAAnimatedTransitionAnimator animationWithFromViewController:self.fromViewController
                                                                          toViewController:self.toViewController transitionDelegate:self.transitionDelegate
                                                                     transitionContextType:self.transitionContextType];
    return animator;
}

@end
