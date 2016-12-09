//
//  GATransitionAnimator.h
//  GACustomTransitions
//
//  Created by Gonçalo Alvarez on 05/02/16.
//  Copyright © 2016 GoncaloAlvarez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GAAnimatedTransitionDelegate.h"
#import "GAAnimatedTransitionAnimatorBuilder.h"
#import "GATransitionAnimator.h"
#import "GATransitionAnimator_Protected.h"

@interface GAAnimatedTransitionAnimator : GATransitionAnimator

+ (GAAnimatedTransitionAnimator *)animationWithFromViewController:(UIViewController *)fromViewController
                                         toViewController:(UIViewController *)toViewController
                                       transitionDelegate:(id<GAAnimatedTransitionDelegate>)transitionDelegate
                                    transitionContextType:(GATransitionContextType)transitionContextType;

- (void)animate;

@end
