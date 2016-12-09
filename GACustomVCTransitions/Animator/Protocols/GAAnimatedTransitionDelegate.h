//
//  GATransitionDelegate.h
//  GACustomTransitions
//
//  Created by Gonçalo Alvarez on 05/02/16.
//  Copyright © 2016 GoncaloAlvarez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GAAnimatedTransitionAnimator;

typedef void (^GATransitionAnimationBlock)(CAAnimation * animation);

@protocol GAAnimatedTransitionDelegate <NSObject>

@optional

- (NSTimeInterval)transitionDurationForAnimator:(GAAnimatedTransitionAnimator *)animator;

- (void)customInitialAnimationForAnimator:(GAAnimatedTransitionAnimator *)animator
                       fromViewController:(UIViewController *)fromViewController
                         toViewController:(UIViewController *)toViewController
                                animation:(GATransitionAnimationBlock)animationBlock;

- (void)customFinalAnimationForAnimator:(GAAnimatedTransitionAnimator *)animator
                     fromViewController:(UIViewController *)fromViewController
                       toViewController:(UIViewController *)toViewController
                             animation:(GATransitionAnimationBlock)animationBlock;

- (void)transitionAnimator:(GAAnimatedTransitionAnimator *)animator didFinishAnimation:(BOOL)didFinish;

@end