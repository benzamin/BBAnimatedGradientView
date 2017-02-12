//
//  BBAnimatedGradientView.m
//  BBAnimatedGradientView
//
//  Created by Benzamin Basher on 2/12/17.
//  Copyright © 2017 Benzamin Basher. All rights reserved.
//  Code adoptation from https://github.com/mmick66/GradientViewiOS/tree/master/KDGradientView

#import "BBAnimatedGradientView.h"

@interface BBAnimatedGradientView()

@property(nonatomic, assign) int lastElementIndex;
@property(nonatomic, assign) int index;
@property(nonatomic, assign) CGFloat factor;

@property(nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation BBAnimatedGradientView



-(void)awakeFromNib{
    [self initiate];
}

-(void)initiate{
    _factor = 1.0;
    _lastElementIndex = 0;
    _index = 0;
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(screenUpdated:)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    _displayLink.paused = YES;
}

-(void)setColors:(NSArray *)colors
{
    _colors = colors;
    _lastElementIndex = (int)colors.count - 1;
}



-(void)animateToNextGradient {
    
    _index = (_index + 1) % _colors.count;
    _factor = 0.0;
    self.displayLink.paused = false;
}

-(void)screenUpdated:(CADisplayLink*)displayLink {
    
    self.factor += (CGFloat)displayLink.duration;
    
    if(self.factor > 1.0) {
        self.displayLink.paused = true;
    }
    
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (self.colors.count < 2) {
        return;
    }

    
    UIColor *c1 = _colors[_index == 0 ? _lastElementIndex : _index - 1];    // => previous color from index
    UIColor *c2 = _colors[_index]                            ;            // => current color
    UIColor *c3 = _colors[_index == _lastElementIndex ? 0 : _index + 1];    // => next color
    
    const CGFloat *c1Comp = CGColorGetComponents(c1.CGColor);
    const CGFloat * c2Comp = CGColorGetComponents(c2.CGColor);
    const CGFloat *c3Comp = CGColorGetComponents(c3.CGColor);
    
    
    CGFloat colorComponents[] = { c1Comp[0] * (1 - _factor) + c2Comp[0] * _factor,
                                  c1Comp[1] * (1 - _factor) + c2Comp[1] * _factor,
                                  c1Comp[2] * (1 - _factor) + c2Comp[2] * _factor,
                                  c1Comp[3] * (1 - _factor) + c2Comp[3] * _factor,
                           
                                  c2Comp[0] * (1 - _factor) + c3Comp[0] * _factor,
                                  c2Comp[1] * (1 - _factor) + c3Comp[1] * _factor,
                                  c2Comp[2] * (1 - _factor) + c3Comp[2] * _factor,
                                  c2Comp[3] * (1 - _factor) + c3Comp[3] * _factor
                           
    };
    CGFloat locations[] = {0.0, 1.0};
    
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents( baseSpace, colorComponents, locations, 2);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextClearRect(context, rect);
    CGContextSaveGState(context);

    CGPoint startPoint = CGPointMake(0.0f, 0.0f);
    CGPoint endPoint = CGPointMake(rect.size.width, rect.size.height);
    
    //GContextClip(context);
    CGContextDrawLinearGradient( context, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient), gradient = NULL;
    
    CGContextRestoreGState(context);
    
    [super drawRect:rect];
}


@end
