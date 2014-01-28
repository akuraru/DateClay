DateClay
========

NSDateを切ったりつないだりするためのライブラリ。（何だこの説明文イミフ）


## Installation

### CocoaPods

``` ruby
pod 'DateClay', :git => https://github.com/akuraru/DateClay.git
```

## Usage

``` objc
// filtering information for the date
+ (NSDate *)filteredDate:(NSDate *)date flag:(NSCalendarUnit)flag;
+ (NSDate *)dateIgnoreTimeWithDate:(NSDate *)date;
+ (NSDate *)dateIgnoreDayWithDate:(NSDate *)date;

// merge information for the date
+ (NSDate *)mergeDateWithDay:(NSDate *)day time:(NSDate *)time;
+ (NSDate *)mergeDateWithBaseDate:(NSDate *)baseDate unitFlag:(enum NSCalendarUnit)baseFlag anotherDate:(NSDate *)anotherDate unitFlag:(enum NSCalendarUnit)anotherFlag;
```

実際の使い方はテストコードを見ろ！

## Contributing
 
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## License

MIT