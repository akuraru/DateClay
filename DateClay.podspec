#
# Be sure to run `pod lib lint DateClay.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DateClay"
  s.version          = "1.1.1"
  s.summary          = "This library will be used in order to connect or cut NSDate."
  s.description      = <<-DESC
                        This library will be used in order to connect or cut NSDate
                                                
                        // filtering information for the date
                        + (NSDate *)filteredDate:(NSDate *)date flag:(NSCalendarUnit)flag;
                        + (NSDate *)dateIgnoreTimeWithDate:(NSDate *)date;
                        + (NSDate *)dateIgnoreDayWithDate:(NSDate *)date;

                        // merge information for the date
                        + (NSDate *)mergeDateWithDay:(NSDate *)day time:(NSDate *)time;
                        + (NSDate *)mergeDateWithBaseDate:(NSDate *)baseDate unitFlag:(enum NSCalendarUnit)baseFlag anotherDate:(NSDate *)anotherDate unitFlag:(enum NSCalendarUnit)anotherFlag;

                        + (NSDate *)day:(NSDate *)date nextWeekday:(NSInteger)weekday;
                       DESC
  s.homepage         = "https://github.com/akuraru/DateClay"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "akuraru" => "akuraru@gmail.com" }
  s.source           = { :git => "https://github.com/akuraru/DateClay.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/akuraru'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  # s.resources = 'Pod/Assets/*.png'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
