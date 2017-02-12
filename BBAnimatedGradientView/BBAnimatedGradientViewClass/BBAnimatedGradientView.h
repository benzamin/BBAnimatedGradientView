//
//  BBAnimatedGradientView.h
//  BBAnimatedGradientView
//
//  Created by Benzamin Basher on 2/12/17.
//  Copyright © 2017 Benzamin Basher. All rights reserved.
//  Code adoptation from https://github.com/mmick66/GradientViewiOS/tree/master/KDGradientView

#import <UIKit/UIKit.h>

@interface BBAnimatedGradientView : UIView

@property(nonatomic, strong) NSArray *colors;

-(void)animateToNextGradient;

@end
