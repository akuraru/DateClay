#import "Kiwi.h"
#import "NSDate+AZDateBuilder.h"
#import "DateClay.h"


@interface DateClay ()
+ (NSArray *)keyForUnit:(enum NSCalendarUnit)unit;
@end

SPEC_BEGIN(DateClayTest)
describe(@"DataCaly", ^{
    let(baseDate, ^{
        return [NSDate AZ_dateByUnit:@{
                AZ_DateUnit.year : @2010,
                AZ_DateUnit.month : @10,
                AZ_DateUnit.day : @10,
                AZ_DateUnit.hour : @20,
                AZ_DateUnit.minute : @15,
                AZ_DateUnit.second : @30,
        }];
    });
    context(@"filtered date", ^{
        it(@"year", ^{
            NSDate *result = [NSDate AZ_dateByUnit:@{
                    AZ_DateUnit.year : @2010,
            }];
            [[[DateClay filteredDate:baseDate flag:NSCalendarUnitYear] should] equal:result];
        });
        it(@"second", ^{
            NSDate *result = [NSDate AZ_dateByUnit:@{
                    AZ_DateUnit.second : @30,
            }];
            [[[DateClay filteredDate:baseDate flag:NSCalendarUnitSecond] should] equal:result];
        });
        it(@"day and minute", ^{
            NSDate *result = [NSDate AZ_dateByUnit:@{
                    AZ_DateUnit.day : @10,
                    AZ_DateUnit.minute : @15,
            }];
            [[[DateClay filteredDate:baseDate flag:NSCalendarUnitDay | NSCalendarUnitMinute] should] equal:result];
        });
    });
    it(@"ignore time", ^{
        NSDate *result = [NSDate AZ_dateByUnit:@{
                AZ_DateUnit.year : @2010,
                AZ_DateUnit.month : @10,
                AZ_DateUnit.day : @10,
        }];
        [[[DateClay dateIgnoreTimeWithDate:baseDate] should] equal:result];
    });
    it(@"ignore day", ^{
        NSDate *result = [NSDate AZ_dateByUnit:@{
                AZ_DateUnit.hour : @20,
                AZ_DateUnit.minute : @15,
                AZ_DateUnit.second : @30,
        }];
        [[[DateClay dateIgnoreDayWithDate:baseDate] should] equal:result];
    });
    context(@"marge Date", ^{
        __block NSDate *anotherDate;
        beforeAll(^{
            anotherDate = [NSDate AZ_dateByUnit:@{
                    AZ_DateUnit.year : @1990,
                    AZ_DateUnit.month : @7,
                    AZ_DateUnit.day : @20,
                    AZ_DateUnit.hour : @8,
                    AZ_DateUnit.minute : @39,
                    AZ_DateUnit.second : @21,
            }];
        });
        it(@"bit cal", ^{
            [[theValue(((NSInteger) pow(2, 0)) << 1) should] equal:theValue(NSCalendarUnitEra)];
        });
        context(@"keyForUnit", ^{
            it(@"era", ^{
                [[[DateClay keyForUnit:NSCalendarUnitEra] should] equal:@[@"era"]];
            });
            it(@"month and minute", ^{
                [[[DateClay keyForUnit:NSCalendarUnitMonth | NSCalendarUnitMinute] should] equal:@[@"month", @"minute"]];
            });
        });
        context(@"mergeDate", ^{
            it(@"year merge month", ^{
                NSDate *result = [NSDate AZ_dateByUnit:@{
                        AZ_DateUnit.year : @2010,
                        AZ_DateUnit.month : @7,
                }];
                [[[DateClay mergeDateWithBaseDate:baseDate unitFlag:NSCalendarUnitYear anotherDate:anotherDate unitFlag:NSCalendarUnitMonth] should] equal:result];
            });
            it(@"(year and month) merge (day and hour)", ^{
                NSDate *result = [NSDate AZ_dateByUnit:@{
                        AZ_DateUnit.year : @2010,
                        AZ_DateUnit.month : @10,
                        AZ_DateUnit.day : @20,
                        AZ_DateUnit.hour : @8,
                }];
                [[[DateClay mergeDateWithBaseDate:baseDate unitFlag:NSCalendarUnitYear | NSCalendarUnitMonth anotherDate:anotherDate unitFlag:NSCalendarUnitDay | NSCalendarUnitHour] should] equal:result];
            });
            it(@"year merge nil", ^{
                NSDate *result = [NSDate AZ_dateByUnit:@{
                        AZ_DateUnit.year : @2010,
                }];
                [[[DateClay mergeDateWithBaseDate:baseDate unitFlag:NSCalendarUnitYear anotherDate:nil unitFlag:NSCalendarUnitMonth] should] equal:result];
            });
            it(@"nil merge month", ^{
                NSDate *result = [NSDate AZ_dateByUnit:@{
                        AZ_DateUnit.month : @7,
                }];
                [[[DateClay mergeDateWithBaseDate:nil unitFlag:NSCalendarUnitYear anotherDate:anotherDate unitFlag:NSCalendarUnitMonth] should] equal:result];
            });
            it(@"nil merge nil", ^{
                [[[DateClay mergeDateWithBaseDate:nil unitFlag:NSCalendarUnitYear anotherDate:nil unitFlag:NSCalendarUnitMonth] should] beNil];
            });
        });
        it(@"mergeDateWithDay:time:", ^{
            NSDate *result = [NSDate AZ_dateByUnit:@{
                    AZ_DateUnit.year : @2010,
                    AZ_DateUnit.month : @10,
                    AZ_DateUnit.day : @10,
                    AZ_DateUnit.hour : @8,
                    AZ_DateUnit.minute : @39,
                    AZ_DateUnit.second : @21,
            }];
            [[[DateClay mergeDateWithDay:baseDate time:anotherDate] should] equal:result];
        });
    });
    context(@"next weekday", ^{
        it(@"next sunday is 7 days ago", ^{
            NSDate *result = [NSDate AZ_dateByUnit:@{
                    AZ_DateUnit.year : @2010,
                    AZ_DateUnit.month : @10,
                    AZ_DateUnit.day : @17,
            }];
            [[[DateClay day:baseDate nextWeekday:1] should] equal:result];
        });
        it(@"next monday is 1 days ago", ^{
            NSDate *result = [NSDate AZ_dateByUnit:@{
                    AZ_DateUnit.year : @2010,
                    AZ_DateUnit.month : @10,
                    AZ_DateUnit.day : @11,
            }];
            [[[DateClay day:baseDate nextWeekday:2] should] equal:result];
        });
    });
    context(@"", ^{
        let(currentTimeZone, ^{ return [NSTimeZone timeZoneForSecondsFromGMT: 9 * 60 * 60]; });
        let(dateBlock, ^{
            return (id)(^(NSTimeZone *timeZone) {
                NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
                dateComponents.calendar = calender;
                dateComponents.timeZone = timeZone;
                dateComponents.year = 2010;
                dateComponents.month = 10;
                dateComponents.day = 10;
                
                dateComponents.hour = 0;
                return [dateComponents date];
            });
        });
        let(localDate, ^{ return ((id(^)(NSTimeZone *))dateBlock)(currentTimeZone); });
        let(gregorianDate, ^{ return ((id(^)(NSTimeZone *))dateBlock)([NSTimeZone timeZoneForSecondsFromGMT:0]); });
        beforeEach(^{
            [NSTimeZone stub:@selector(localTimeZone) andReturn:currentTimeZone];
        });
        it(@"-gregorianDateForLocalDate:", ^{
            [[[DateClay gregorianDateForLocalDate:localDate] should] equal:gregorianDate];
        });
        it(@"-localDateForGregorianDate", ^{
            [[[DateClay localDateForGregorianDate:gregorianDate] should] equal:localDate];
        });
        it(@"reverce", ^{
            [[[DateClay localDateForGregorianDate:[DateClay gregorianDateForLocalDate:localDate]] should] equal:localDate];
            
        });
    });
});
SPEC_END
