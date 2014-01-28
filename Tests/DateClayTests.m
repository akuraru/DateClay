#import "Kiwi.h"
#import "NSDate+AZDateBuilder.h"
#import "DateClay.h"


@interface DateClay ()
+ (NSArray *)keyForUnit:(enum NSCalendarUnit)unit;
@end

SPEC_BEGIN(DateClayTest)
context(@"", ^{
    __block NSDate *baseDate;
    beforeAll(^{
        baseDate = [NSDate AZ_dateByUnit:@{
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
});
SPEC_END