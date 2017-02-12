//
//  ViewController.m
//  BBAnimatedGradientView
//
//  Created by Benzamin Basher on 2/12/17.
//  Copyright © 2017 Benzamin Basher. All rights reserved.
//

#import "ViewController.h"
#import "BBAnimatedGradientView.h"



@interface ViewController ()

@property(nonatomic, weak) IBOutlet UIView *inputView;
@property(nonatomic, weak) IBOutlet BBAnimatedGradientView *backgroundView;
@property(nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.inputView.layer.cornerRadius = 10;
    
    //set the background colors here. IMPORTANT: You might need to adjust the timer interval to match the number of colors.
    self.backgroundView.colors = @[
                                   [UIColor blueColor],
                                   [UIColor cyanColor],
                                   [UIColor greenColor],
                                   [UIColor yellowColor],
                                   [UIColor redColor],
                                   [UIColor magentaColor]
                                   ];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if(!self.timer.isValid)
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.backgroundView.colors.count*0.25f //might need adjustment
                                                      target:self
                                                    selector:@selector(animationTimerTick)
                                                    userInfo:nil
                                                     repeats:YES];//animating the background
    [self animationTimerTick];
}

-(void)animationTimerTick
{
    [self.backgroundView animateToNextGradient];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    if(self.timer){
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
