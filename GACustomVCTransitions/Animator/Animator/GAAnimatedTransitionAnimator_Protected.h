//
//  GAAnimatedTransitionAnimator_Protected.h
//  GACustomTransitions
//
//  Created by Gonçalo Alvarez on 06/02/16.
//  Copyright © 2016 GoncaloAlvarez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GATransitionAnimator_Protected.h"
#import "GAAnimatedTransitionAnimator.h"

@interface GAAnimatedTransitionAnimator ()

- (instancetype)initWithFromViewController:(UIViewController *)fromViewController
                          toViewController:(UIViewController *)toViewController
                        transitionDelegate:(id<GAAnimatedTransitionDelegate>)delegate;

@property (nonatomic, weak) id <GAAnimatedTransitionDelegate> transitionDelegate;

@end
