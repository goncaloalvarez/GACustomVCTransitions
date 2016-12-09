//
//  GATransitionAnimatorBuilder.h
//  GACustomTransitions
//
//  Created by Gonçalo Alvarez on 05/02/16.
//  Copyright © 2016 GoncaloAlvarez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GATransitionEnums.h"

typedef void (^GATransitionAnimationBlock)(CAAnimation * animation);

@class GAAnimatedTransitionAnimator;
@protocol GAAnimatedTransitionDelegate;

@interface GAAnimatedTransitionAnimatorBuilder : NSObject

- (instancetype)initWithFromViewController:(UIViewController *)fromViewController
                          toViewController:(UIViewController *)toViewController
                        transitionDelegate:(id<GAAnimatedTransitionDelegate>)transitionDelegate;

- (GAAnimatedTransitionAnimatorBuilder *)configureTransitionContextType:(GATransitionContextType)transitionContextType;

- (GAAnimatedTransitionAnimator *)build;



@end
