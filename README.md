# DateClay

[![CI Status](http://img.shields.io/travis/akuraru/DateClay.svg?style=flat)](https://travis-ci.org/akuraru/DateClay)
[![Version](https://img.shields.io/cocoapods/v/DateClay.svg?style=flat)](http://cocoadocs.org/docsets/DateClay)
[![License](https://img.shields.io/cocoapods/l/DateClay.svg?style=flat)](http://cocoadocs.org/docsets/DateClay)
[![Platform](https://img.shields.io/cocoapods/p/DateClay.svg?style=flat)](http://cocoadocs.org/docsets/DateClay)

## Requirements

## Installation

DateClay is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "DateClay"


## Usage


``` objc
// filtering information for the date
+ (NSDate *)filteredDate:(NSDate *)date flag:(NSCalendarUnit)flag;
+ (NSDate *)dateIgnoreTimeWithDate:(NSDate *)date;
+ (NSDate *)dateIgnoreDayWithDate:(NSDate *)date;

// merge information for the date
+ (NSDate *)mergeDateWithDay:(NSDate *)day time:(NSDate *)time;
+ (NSDate *)mergeDateWithBaseDate:(NSDate *)baseDate unitFlag:(enum NSCalendarUnit)baseFlag anotherDate:(NSDate *)anotherDate unitFlag:(enum NSCalendarUnit)anotherFlag;

+ (NSDate *)day:(NSDate *)date nextWeekday:(NSInteger)weekday;
```

Please look at the test code for how to use

## Author

akuraru, akuraru@gmail.com

## License

DateClay is available under the MIT license. See the LICENSE file for more info.

