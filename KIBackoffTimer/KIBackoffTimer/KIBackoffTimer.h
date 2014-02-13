//
//  KIBackoffTimer.h
//  KIBackoffTimer
//
//  Created by Marcus Kida on 13.02.14.
//  Copyright (c) 2014 Marcus Kida. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KIBackoffTimer : NSTimer

@property (assign) BOOL finished;

+ (KIBackoffTimer *) backoffTimerWithBlock:(void(^)(KIBackoffTimer *timer))block;

@end
