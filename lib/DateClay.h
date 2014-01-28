//
//  NSDateClay.h
//  MotherChildHandbook
//
//  Created by P.I.akura on 2013/10/02.
//  Copyright (c) 2013年 P.I.akura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateClay : NSObject

+ (NSDate *)dateIgnoreTimeWithDate:(NSDate *)date;

+ (NSDate *)dateIgnoreDayWithDate:(NSDate *)date;

+ (NSDate *)margeDateWithDay:(NSDate *)day time:(NSDate *)time;

+ (NSDate *)margeDateWithBaseDate:(NSDate *)baseDate unitFlag:(enum NSCalendarUnit)baseFlag otherDate:(NSDate *)otherDate unitFlag:(enum NSCalendarUnit)otherFlag;
@end
