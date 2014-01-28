//
//  NSDateClay.m
//  MotherChildHandbook
//
//  Created by P.I.akura on 2013/10/02.
//  Copyright (c) 2013年 P.I.akura. All rights reserved.
//

#import "DateClay.h"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)

@implementation DateClay

+ (NSDate *)dateIgnoreTimeWithDate:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    calendar.locale = [NSLocale currentLocale];
    NSDateComponents *dateComps = [calendar components:NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    
    return [calendar dateFromComponents:dateComps];
}
+ (NSDate *)dateIgnoreDayWithDate:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    calendar.locale = [NSLocale currentLocale];
    NSDateComponents *dateComps = [calendar components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:date];
    
    return [calendar dateFromComponents:dateComps];
}

+ (NSDate *)margeDateWithDay:(NSDate *)day time:(NSDate *)time {
    if (day && time) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [calendar setTimeZone:[NSTimeZone localTimeZone]];
        NSDateComponents *dateCompsDay = [calendar components:NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:day];
        NSDateComponents *dateCompsTime = [calendar components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:time];

        [dateCompsDay setHour:dateCompsTime.hour];
        [dateCompsDay setMinute:dateCompsTime.minute];
        [dateCompsDay setSecond:dateCompsTime.second];

        return [calendar dateFromComponents:dateCompsDay];
    } else if (day) {
        return [self dateIgnoreTimeWithDate:day];
    } else if (time) {
        return [self dateIgnoreDayWithDate:time];
    } else {
        return nil;
    }
}

+ (NSDate *)margeDateWithBaseDate:(NSDate *)baseDate unitFlag:(enum NSCalendarUnit)baseFlag otherDate:(NSDate *)otherDate unitFlag:(enum NSCalendarUnit)otherFlag{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    NSDateComponents *dateCompsBase = [calendar components:baseFlag fromDate:baseDate];
    NSDateComponents *dateCompsOther = [calendar components:otherFlag fromDate:otherDate];

    for (NSString *key in [self keyForUnit:otherFlag]) {
        [dateCompsBase setValue:[dateCompsOther valueForKey:key] forKey:key];
    }
    return [calendar dateFromComponents:dateCompsBase];
}

+ (id <NSFastEnumeration>)keyForUnit:(enum NSCalendarUnit)unit {
    NSArray *params = @[@"era", @"year", @"month", @"day", @"hour", @"minute", @"second", @"week", @"weekday", @"weekdayOrdinal", @"quarter", @"weekOfMonth", @"weekOfYear", @"yearForWeekOfYear"];
    return [params objectsAtIndexes:[params indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return ((NSInteger) pow(2, idx)) & unit;
    }]];
}
@end
