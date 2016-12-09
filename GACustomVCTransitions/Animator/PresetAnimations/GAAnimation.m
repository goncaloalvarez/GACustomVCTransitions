//
//  GAAnimation.m
//  GACustomTransitions
//
//  Created by Gonçalo Alvarez on 07/02/16.
//  Copyright © 2016 GoncaloAlvarez. All rights reserved.
//

#import "GAAnimation.h"
#import <UIKit/UIKit.h>

@implementation GAAnimation

+ (CAAnimation *)animationWithType:(GAAnimationType)animationType {

    switch (animationType) {
        case GAAnimationTypeDefaultModalIn: {
            
            return [GAAnimation defaultModalInAnimation];
            
        }
        case GAAnimationTypeDefaultModalDismissal: {
            
            return [GAAnimation defaultModalDismissalAnimation];
            
        }
        case GAAnimationTypeDefaultPush: {
            
            return [GAAnimation defaultPushAnimation];
            
        }
        case GAAnimationTypeDefaultPop: {
            
            return [GAAnimation defaulPopAnimation];
            
        }
        default: {
        
            return nil;
        }
    }
    
    return nil;
}

#pragma mark - Private

+ (CAAnimation *)defaultModalInAnimation {

    CGRect initialFrame = [[[[UIApplication sharedApplication] windows] firstObject] frame];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.y";
    animation.fromValue = @(initialFrame.size.height * 1.5);
    animation.toValue = @(initialFrame.size.height * .5);
    animation.duration = 0.4;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    return animation;
}

+ (CAAnimation *)defaultModalDismissalAnimation {
    
    CGRect initialFrame = [[[[UIApplication sharedApplication] windows] firstObject] frame];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.y";
    animation.fromValue = @(initialFrame.size.height * .5);
    animation.toValue = @(initialFrame.size.height * 1.5);
    animation.duration = 0.4;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    return animation;
}

+ (CAAnimation *)defaultPushAnimation {
    
    CGRect initialFrame = [[[[UIApplication sharedApplication] windows] firstObject] frame];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.fromValue = @(initialFrame.size.width * 1.5);
    animation.toValue = @(initialFrame.size.width * 0.5);
    animation.duration = 0.4;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    return animation;
}

+ (CAAnimation *)defaulPopAnimation {
    
    CGRect initialFrame = [[[[UIApplication sharedApplication] windows] firstObject] frame];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.fromValue = @(initialFrame.size.width * .5);
    animation.toValue = @(initialFrame.size.width * 1.5);
    animation.duration = 0.4;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    return animation;
}

@end
