//
//  GAAnimation.h
//  GACustomTransitions
//
//  Created by Gonçalo Alvarez on 07/02/16.
//  Copyright © 2016 GoncaloAlvarez. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSUInteger, GAAnimationType) {

    GAAnimationTypeDefaultModalIn,
    GAAnimationTypeDefaultModalDismissal,
    GAAnimationTypeDefaultPush,
    GAAnimationTypeDefaultPop
};

@interface GAAnimation : NSObject

+ (CAAnimation *)animationWithType:(GAAnimationType)animationType;

@end
