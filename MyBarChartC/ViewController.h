//
//  ViewController.h
//  MyBarChartC
//
//  Created by Aurionpro2 on 15/05/15.
//  Copyright (c) 2015 Aurionpro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface ViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (nonatomic, strong) UIView *barView;

@property (nonatomic, strong) UIView *containerView;

- (void)centerScrollViewContents;
@property (weak, nonatomic) IBOutlet UIView *propViewLagendYHolder;

@end




