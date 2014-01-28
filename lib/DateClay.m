//
//  NSDateClay.m
//  MotherChildHandbook
//
//  Created by P.I.akura on 2013/10/02.
//  Copyright (c) 2013年 P.I.akura. All rights reserved.
//

#import "DateClay.h"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define DATE_DAY_COMPONENTS (NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
#define DATE_TIME_COMPONENTS (NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit)
#define DATE_

@implementation DateClay

+ (NSDate *)filteredDate:(NSDate *)date flag:(NSCalendarUnit)flag {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    calendar.locale = [NSLocale currentLocale];
    NSDateComponents *dateComps = [calendar components:flag fromDate:date];

    return [calendar dateFromComponents:dateComps];
}

+ (NSDate *)dateIgnoreTimeWithDate:(NSDate *)date {
    return [self filteredDate:date flag:DATE_DAY_COMPONENTS];
}

+ (NSDate *)dateIgnoreDayWithDate:(NSDate *)date {
    return [self filteredDate:date flag:DATE_TIME_COMPONENTS];
}

+ (NSDate *)mergeDateWithBaseDate:(NSDate *)baseDate unitFlag:(enum NSCalendarUnit)baseFlag anotherDate:(NSDate *)anotherDate unitFlag:(enum NSCalendarUnit)anotherFlag {
    if (baseDate && anotherDate) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [calendar setTimeZone:[NSTimeZone localTimeZone]];
        NSDateComponents *dateCompsBase = [calendar components:baseFlag fromDate:baseDate];
        NSDateComponents *dateCompsOther = [calendar components:anotherFlag fromDate:anotherDate];

        for (NSString *key in [self keyForUnit:anotherFlag]) {
            [dateCompsBase setValue:[dateCompsOther valueForKey:key] forKey:key];
        }
        return [calendar dateFromComponents:dateCompsBase];
    } else if (baseDate) {
        return [self filteredDate:baseDate flag:baseFlag];
    } else if (anotherDate) {
        return [self filteredDate:anotherDate flag:anotherFlag];
    } else {
        return nil;
    }
}

+ (NSDate *)mergeDateWithDay:(NSDate *)day time:(NSDate *)time {
    return [self mergeDateWithBaseDate:day unitFlag:DATE_DAY_COMPONENTS anotherDate:time unitFlag:DATE_TIME_COMPONENTS];
}

+ (NSArray *)keyForUnit:(enum NSCalendarUnit)unit {
    NSArray *params = @[@"era", @"year", @"month", @"day", @"hour", @"minute", @"second", @"week", @"weekday", @"weekdayOrdinal", @"quarter", @"weekOfMonth", @"weekOfYear", @"yearForWeekOfYear"];
    return [params objectsAtIndexes:[params indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return ((NSInteger) pow(2, idx) << 1) & unit;
    }]];
}
@end
