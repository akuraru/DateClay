//
//  NSDateClay.h
//  MotherChildHandbook
//
//  Created by P.I.akura on 2013/10/02.
//  Copyright (c) 2013年 P.I.akura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateClay : NSObject

+ (NSDate *)filteredDate:(NSDate *)date flag:(NSCalendarUnit)flag;

+ (NSDate *)dateIgnoreTimeWithDate:(NSDate *)date;

+ (NSDate *)dateIgnoreDayWithDate:(NSDate *)date;

+ (NSDate *)mergeDateWithDay:(NSDate *)day time:(NSDate *)time;

+ (NSDate *)mergeDateWithBaseDate:(NSDate *)baseDate unitFlag:(enum NSCalendarUnit)baseFlag anotherDate:(NSDate *)anotherDate unitFlag:(enum NSCalendarUnit)anotherFlag;
@end
