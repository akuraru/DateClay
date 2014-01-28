require 'kconv'
require 'fileutils'
require "csv"

$hierarchical = 0
$help = false
$non = false
$liner = false
$fileName = ""
$ignoreBlank = false
$/

require 'optparse'
opt = OptionParser.new
opt.on("-a [number]", "--array [number]") {|v| $hierarchical = v.to_i }
opt.on("-l", "--liner") {|v| $liner = true }
opt.on('-h', '--help') {|v| $help = true }
opt.on('--none') {|v| $non = true }
opt.on('-i', '--ignoreBlank') {|v| $ignoreBlank = true }
opt.on("-f [file]", "--file_name [file]") {|v| $fileName = v}

opt.permute!(ARGV)

class NSObject
  def initialize(depth, data)
    @depth = depth
    @type = data
  end
  def depth
    @depth
  end
  def type
    @type
  end
  def == (type)
    NSObject === type && @depth == type.depth && @type == type.type
  end
  def indent
    "    " * @depth
  end
end
class NSArray < NSObject
  def initialize(depth, data, label=nil, hierarch = 0)
    super(depth, self.cData(depth, data, label, hierarch))
  end
  def cData(depth, data, label, hierarch)
    if (label)
      self.perse(depth, data, label, hierarch)
    else
      data
    end
  end
  def perse(depth, data, label, hierarch)
    if (hierarch == 0) then
      if ($liner) then
        self.liner(depth, data, label, hierarch)
      else
        data.map{|d| NSDictionary.new(depth + 1, d, label)}
      end
    else
      self.hierarch(depth, data, label, hierarch)
    end
  end
  def liner(depth, data, label, hierarch)
    if (label.count == 1) then
      if ($ignoreBlank) then
        data = data.reject {|s| s == ""}
      end
      if (String === data[0]) then
        data.map{|d| NSString.new(depth + 1, d)}
      else
        data.map{|d| NSString.new(depth + 1, d[0])}
     end
    else
      data.map{|d| NSArray.new(depth + 1, d, [""], hierarch)}
    end
  end
  def hierarch(depth, data, label, hierarch)
    index = -1
    data.inject([[]]){|a, d|
      if (d[0].to_i <= index) then
        a.push([])
      end
        a[-1].push(d[1..-1])
        index = d[0].to_i
        a
    }.map{|s| NSArray.new(depth + 1, s, label[1..-1], hierarch - 1)}
  end
  def == (type)
    NSArray === type && super(type)
  end
  def to_s
    self.indent() + "<array>\n" +
    @type.inject(""){|n,a| n + a.to_s} +
    self.indent() + "</array>\n"
  end
end
class NSDictionary < NSObject
  def initialize(depth, data, label=nil)
    super(depth, self.cData(depth, data, label))
  end
  def cData(depth, data, label)
    if (label)
      self.perse(depth, data, label)
    else
      data
    end
  end
  def perse(depth, data, label)
    if ($ignoreBlank) then
        data = data.reject {|s| s == ""}
    end
    data.map{|s| NSString.new(depth + 1, s)}.zip(label.map{|s| NSKey.new(depth + 1, s)})
  end
  def to_s
    self.indent() + "<dict>\n" +
    @type.inject(""){|n,a| n + a.inject(""){|n, s| s.to_s + n}} +
    self.indent() + "</dict>\n"
  end
  def == (type)
    NSDictionary === type && super(type)
  end
end
class NSKey < NSObject
  def to_s
    "#{self.indent()}<key>#{@type}</key>\n"
  end
  def == (type)
    NSKey === type && super(type)
  end
end
class NSString < NSObject
  def to_s
    "#{self.indent()}<string>#{@type}</string>\n"
  end
  def == (type)
    NSString === type && super(type)
  end
end
  
class CsvToPlist
  def initialize
  end
  def fileRead(fileName)
    data = []
    CSV.foreach(fileName, :encoding => Encoding::UTF_8){|row|
      data.push(row.map{|s| s.to_s.gsub(/&/, "&amp;").gsub(/>/, "&gt;").gsub(/</, "&lt;")})
    }
    data
  end
  def exchange(arrStr)
    NSArray.new(0, arrStr[1..-1], arrStr[0], $hierarchical)
  end
  def header(type, fileName)
    "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version=\"1.0\">\n" +
    type.to_s +
    '</plist>'
  end
  def main(file, dir)
    type = self.exchange(self.fileRead(file))
    fileName = if $fileName == "" then
      File.basename(file, ".*")
    else
      $fileName
    end
    
    head = "#{dir}#{fileName}.plist"
    FileUtils.mkdir_p(dir) unless FileTest.exist?(dir)
    File.open(head, "w:UTF-16"){|f|
      f.write self.header(type, fileName)
    }
  end
end
if $non
elsif ARGV.count < 2 || $help
  puts "UserDefaultsCreator: Usage [Option] <argumrnt> [...]"
  puts "need more than 2 argv"
  puts ""
    puts "-a [number], --array [number]  Use hierarchical structure"
    puts "-l, --list  Use hierarchical structure"
    puts "-i, --ignoreBlank ignore Blank line"
    puts "-f [file], --file_name [file]"
elsif ARGV.count >= 2
  CsvToPlist.new.main(ARGV[0], ARGV[1])
  puts "Generate"
end
