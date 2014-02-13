//
//  KIBackoffTimer.m
//  KIBackoffTimer
//
//  Created by Marcus Kida on 13.02.14.
//  Copyright (c) 2014 Marcus Kida. All rights reserved.
//

#import "KIBackoffTimer.h"

@interface KIBackoffTimer ()

@property (assign) NSTimeInterval timeInterval;
@property (strong) NSTimer *backoffTimer;

@property (copy) void (^backoffBlock)(KIBackoffTimer *timer);

@end

@implementation KIBackoffTimer

+ (KIBackoffTimer *) backoffTimerWithBlock:(void (^)(KIBackoffTimer *timer))block
{
    KIBackoffTimer *this = [[KIBackoffTimer alloc] init];
    this.timeInterval = 0.0f;
    this.backoffTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:this selector:@selector(executeBackoffInterval:) userInfo:nil repeats:NO];
    this.backoffBlock = block;
    return this;
}

-(void)executeBackoffInterval:(NSTimer *)timer
{
    self.backoffBlock(self);
    
    if (!self.finished) {
        _timeInterval = _timeInterval >= 0.1 ? _timeInterval * 2 : 0.1;
        _timeInterval = MIN(60.0, _timeInterval);
        _backoffTimer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(executeBackoffInterval:) userInfo:nil repeats:NO];
        return;
    }
    
    [_backoffTimer invalidate];
}

@end
