//
//  GATransitionAnimator.h
//  GACustomTransitions
//
//  Created by Gonçalo Alvarez on 06/02/16.
//  Copyright © 2016 GoncaloAlvarez. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, GAAnimationTransitionState) {
    
    GAAnimationTransitionStateInitial,
    GAAnimationTransitionStateFinal
};

@interface GATransitionAnimator : NSObject

@end
