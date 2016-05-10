//
//  ViewController.m
//  LocationMonitorDemo
//
//  Created by  周轶飞 on 16/4/19.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ViewController.h"

#import "AppDelegate.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *bgStartButton;

@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *bgStopButton;

@property (weak, nonatomic) IBOutlet UILabel *presentLabel;
@property (weak, nonatomic) IBOutlet UILabel *bgPresentLabel;

@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.presentLabel setText:@"FG: NOT Enabled"];
    [self.bgPresentLabel setText:@"BG: NOT Enabled"];
    
    [self.showLabel setText:@"No Position"];
    
    [self.startButton addTarget:self action:@selector(startFg) forControlEvents:UIControlEventTouchUpInside];
    [self.bgStartButton addTarget:self action:@selector(startBg) forControlEvents:UIControlEventTouchUpInside];
    [self.stopButton addTarget:self action:@selector(stopFg) forControlEvents:UIControlEventTouchUpInside];
    [self.bgStopButton addTarget:self action:@selector(stopBg) forControlEvents:UIControlEventTouchUpInside];
}

- (void)startFg {
    [self.presentLabel setText:@"FG: Enabled"];
}

- (void)startBg {
    [self.bgPresentLabel setText:@"BG: Enabled"];
}

- (void)stopFg {
    [self.presentLabel setText:@"FG: NOT Enabled"];
}

- (void)stopBg {
    [self.bgPresentLabel setText:@"BG: NOT Enabled"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
