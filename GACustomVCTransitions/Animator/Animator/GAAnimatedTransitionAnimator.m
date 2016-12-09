//
//  GATransitionAnimator.m
//  GACustomTransitions
//
//  Created by Gonçalo Alvarez on 05/02/16.
//  Copyright © 2016 GoncaloAlvarez. All rights reserved.
//

#import "GAAnimatedTransitionAnimator.h"
#import "GAAnimatedTransitionAnimator_Protected.h"
#import "GAAnimatedTransitionDelegate.h"
#import "GAAnimation.h"

static const NSTimeInterval kDefaultTransitionDuration = 1.0;

@interface GAModalAnimatedTransitionAnimator: GAAnimatedTransitionAnimator <UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>

@end

@implementation GAModalAnimatedTransitionAnimator

@synthesize transitionDelegate;
@synthesize fromVC;
@synthesize toVC;
@synthesize transitionState;

#pragma mark - Lifecycle

- (instancetype)initWithFromViewController:(UIViewController *)fromViewController
                          toViewController:(UIViewController *)toViewController
                        transitionDelegate:(id<GAAnimatedTransitionDelegate>)delegate {

    self = [super init];
    
    if (self) {
    
        self.fromVC = fromViewController;
        self.toVC = toViewController;
        self.transitionDelegate = delegate;
    }
    
    return self;
}

#pragma mark - Public

- (void)animate {

    self.toVC.modalPresentationStyle = UIModalPresentationCustom;
    self.toVC.transitioningDelegate = self;
    
    [self.fromVC presentViewController:self.toVC
                                          animated:YES
                                        completion:nil];
}

#pragma mark - UIViewControllerAnimatedTransitioningr

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    if ([self.transitionDelegate respondsToSelector:@selector(transitionDurationForAnimator:)]) {
        
        return [self.transitionDelegate transitionDurationForAnimator:self];
    }
    
    return kDefaultTransitionDuration;
}

- (void)animationEnded:(BOOL)transitionCompleted {
    
    if ([self.transitionDelegate respondsToSelector:@selector(transitionAnimator:didFinishAnimation:)]) {
    
        [self.transitionDelegate transitionAnimator:self didFinishAnimation:transitionCompleted];
    }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    if (self.transitionState == GAAnimationTransitionStateInitial) {
    
        if ([self.transitionDelegate respondsToSelector:@selector(customInitialAnimationForAnimator:fromViewController:toViewController:animation:)]) {
     
            UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
            
            [[transitionContext containerView] addSubview:toViewController.view];
            
            [self.transitionDelegate customInitialAnimationForAnimator:self
                                                    fromViewController:self.fromVC
                                                      toViewController:self.toVC
                                                             animation:^(CAAnimation * animation) {
                                                          
                                                                 if (animation) {
                    
                                                                     [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                                                                 }
                                    
                return;
            }];
                
        } else {
            
            UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
            
            [[transitionContext containerView] addSubview:toViewController.view];
            
            [CATransaction begin];
            
            [CATransaction setCompletionBlock:^{
                
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
            
            CAAnimation *animation = [GAAnimation animationWithType:GAAnimationTypeDefaultModalIn];
            
            CGRect initialFrame = [[[[UIApplication sharedApplication] windows] firstObject] frame];
            
            [toViewController.view.layer addAnimation:animation forKey:@"basic"];
            toViewController.view.layer.frame = initialFrame;
            
            [CATransaction commit];
        }
        
    } else {
    
        if ([self.transitionDelegate respondsToSelector:@selector(customFinalAnimationForAnimator:fromViewController:toViewController:animation:)]) {
            
            [self.transitionDelegate customFinalAnimationForAnimator:self
                                                    fromViewController:self.fromVC
                                                      toViewController:self.toVC
                                                             animation:^(CAAnimation * animation) {
                                                                 
                                                                 if (animation) {
                                                                     
                                                                     [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                                                                 }
                                                                 
                                                                 return;
                                                             }];
            
        } else {
            
            UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
            
            [CATransaction begin];
            
            [CATransaction setCompletionBlock:^{
                
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
            
            CAAnimation *animation = [GAAnimation animationWithType:GAAnimationTypeDefaultModalDismissal];
            
            [fromViewController.view.layer addAnimation:animation forKey:@"basic"];
            
            [CATransaction commit];
        }
        
    }
}

#pragma mark - UIVieControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    
    self.transitionState = GAAnimationTransitionStateInitial;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    self.transitionState = GAAnimationTransitionStateFinal;
    return self;
}

@end

@interface GAPushAnimatedTransitionAnimator: GAAnimatedTransitionAnimator <UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate>

@property (nonatomic, assign) UINavigationControllerOperation navigationControllerOperation;

@end

@implementation GAPushAnimatedTransitionAnimator

@synthesize transitionDelegate;
@synthesize toVC;
@synthesize fromVC = _fromVC;
@synthesize transitionState;

#pragma mark - Lifecycle

- (instancetype)initWithFromViewController:(UIViewController *)fromViewController
                          toViewController:(UIViewController *)toViewController
                        transitionDelegate:(id<GAAnimatedTransitionDelegate>)delegate {
    
    self = [super init];
    
    if (self) {
        
        self.fromVC = fromViewController;
        self.toVC = toViewController;
        self.transitionDelegate = delegate;
    }
    
    return self;
}

- (void)dealloc {

    _fromVC.navigationController.delegate = nil;
}

#pragma mark - Public

- (void)animate {
    
    if (self.fromVC.navigationController) {
    
        self.fromVC.navigationController.delegate = self;
        [self.fromVC.navigationController pushViewController:self.toVC animated:YES];
    }
}

#pragma mark - UIViewControllerAnimatedTransitioningr

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    if ([self.transitionDelegate respondsToSelector:@selector(transitionDurationForAnimator:)]) {
        
        return [self.transitionDelegate transitionDurationForAnimator:self];
    }
    
    return kDefaultTransitionDuration;
}

- (void)animationEnded:(BOOL)transitionCompleted {
    
    if ([self.transitionDelegate respondsToSelector:@selector(transitionAnimator:didFinishAnimation:)]) {
        
        [self.transitionDelegate transitionAnimator:self didFinishAnimation:transitionCompleted];
    }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (self.navigationControllerOperation == UINavigationControllerOperationPush) {
    
        if ([self.transitionDelegate respondsToSelector:@selector(customInitialAnimationForAnimator:fromViewController:toViewController:animation:)]) {
            
            [[transitionContext containerView] addSubview:toViewController.view];
            
            [CATransaction begin];
            
            [CATransaction setCompletionBlock:^{
                
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
       
            [self.transitionDelegate customInitialAnimationForAnimator:self
                                                    fromViewController:self.fromVC
                                                      toViewController:self.toVC
                                                             animation:^(CAAnimation * animation) {
                                                            
                                                            if (animation) {

                                                            }
                                                          
                                                            return;
                                                      }];
            
            [CATransaction commit];
            
        } else {
            
            [[transitionContext containerView] insertSubview:toViewController.view aboveSubview:fromViewController.view];
        
            [CATransaction begin];
            
            [CATransaction setCompletionBlock:^{
                
                [transitionContext completeTransition:YES];
            }];
            
            CAAnimation *animation = [GAAnimation animationWithType:GAAnimationTypeDefaultPush];
            
            CGRect initialFrame = [[[[UIApplication sharedApplication] windows] firstObject] frame];
            
            [toViewController.view.layer addAnimation:animation forKey:@"basic"];
            toViewController.view.layer.frame = initialFrame;
            
            [CATransaction commit];
        }
        
    } else {

        [[transitionContext containerView] insertSubview:toViewController.view belowSubview:fromViewController.view];
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            
            [transitionContext completeTransition:YES];

        }];
        
        CAAnimation *animation = [GAAnimation animationWithType:GAAnimationTypeDefaultPop];
        [fromViewController.view.layer addAnimation:animation forKey:@"basic"];
        [CATransaction commit];
    }
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {

    self.navigationControllerOperation = operation;
    return self;
}

@end

@implementation GAAnimatedTransitionAnimator

#pragma mark - Lifecycle

- (instancetype)initWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController transitionDelegate:(id<GAAnimatedTransitionDelegate>)delegate{

    @throw([NSException exceptionWithName:@"Exception" reason:@"Shouldn't call parent implementation" userInfo:@{}]);
}

#pragma mark - Public

+ (GAAnimatedTransitionAnimator *)animationWithFromViewController:(UIViewController *)fromViewController
                                                 toViewController:(UIViewController *)toViewController
                                               transitionDelegate:(id<GAAnimatedTransitionDelegate>)transitionDelegate
                                            transitionContextType:(GATransitionContextType)transitionContextType {

    switch (transitionContextType) {
            
        case GATransitionContextTypeModal: {
            
            GAModalAnimatedTransitionAnimator *animator = [[GAModalAnimatedTransitionAnimator alloc] initWithFromViewController:fromViewController
                                                                                                     toViewController:toViewController transitionDelegate:transitionDelegate];

            return animator;
        }
            
        case GATransitionContextTypePush: {
            
            GAPushAnimatedTransitionAnimator *animator = [[GAPushAnimatedTransitionAnimator alloc] initWithFromViewController:fromViewController
                                                                                                               toViewController:toViewController transitionDelegate:transitionDelegate];
            
            return animator;
        }
    }
    
    return nil;
}

- (void)animate {

    @throw([NSException exceptionWithName:@"Exception" reason:@"Shouldn't call parent implementation" userInfo:@{}]);
}

@end