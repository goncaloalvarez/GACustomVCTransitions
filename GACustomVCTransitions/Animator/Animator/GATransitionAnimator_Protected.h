//
//  GATransitionAnimator_Protected.h
//  GACustomTransitions
//
//  Created by Gonçalo Alvarez on 06/02/16.
//  Copyright © 2016 GoncaloAlvarez. All rights reserved.
//

#import "GATransitionAnimator.h"

@interface GATransitionAnimator ()

@property (nonatomic, weak) UIViewController *toVC;
@property (nonatomic, weak) UIViewController *fromVC;
@property (nonatomic, assign) GAAnimationTransitionState transitionState;

@end