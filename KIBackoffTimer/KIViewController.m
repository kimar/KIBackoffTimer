//
//  KIViewController.m
//  KIBackoffTimer
//
//  Created by Marcus Kida on 13.02.14.
//  Copyright (c) 2014 Marcus Kida. All rights reserved.
//

#import "KIViewController.h"
#import "KIBackoffTimer.h"

@interface KIViewController ()

@property (strong) IBOutlet UILabel *label;
@property (strong) IBOutlet UIButton *button;

@property (strong) KIBackoffTimer *backoffTimer;

@end

@implementation KIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction) startBackoffTimer:(id)sender
{
    self.button.enabled = NO;
    
    __block KIViewController *this = self;
    self.backoffTimer = [KIBackoffTimer backoffTimerWithBlock:^(KIBackoffTimer *timer) {
        this.label.text = [NSString stringWithFormat:@"Last interval lasted %f sec.", timer.timeInterval];
        if (timer.timeInterval > 1.6) {
            this.label.text = [NSString stringWithFormat:@"Timer stopped!"];
            timer.finished = YES;
            this.button.enabled = YES;
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
