# KeyedArchive

A Ruby gem for working with files produced by NSKeyedArchiver.

## Installation

Add this line to your application's Gemfile:

    gem 'keyed_archive'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install keyed_archive

## Usage

### Basic Syntax

KeyedArchive supports the initializer arguments which CFPropertyList supports: `:file` to read data directly from a file and `:data` to read data from a variable that already has your NSKeyedArchive data within it.

```ruby

# Create KeyedArchive by reading a file directly
keyed_archive_from_file = KeyedArchive.new(:file => "path/to/file.plist")

# Create KeyedArchive from a variable holding content which can 
# be parsed as a plist, either XML or binary. 
file_contents = File.read("path/to/file.plist")
keyed_archive_from_variable = KeyedArchive.new(:data => file_contents)

```

### Opening a keyed archive
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>$version</key>
  <integer>100000</integer>
  <key>$objects</key>
  <array>
    <string>$null</string>
  </array>
  <key>$archiver</key>
  <string>NSKeyedArchiver</string>
  <key>$top</key>
  <dict>
    <key>root</key>
    <dict>
      <key>CF$UID</key>
      <integer>1</integer>
    </dict>
  </dict>
</dict>
</plist>
```

```ruby
require 'keyed_archive'

filename = "path/to/file.plist"
keyed_archive = KeyedArchive.new(:file => "path/to/file.plist")
keyed_archive.archiver     # "NSKeyedArchiver"
keyed_archive.objects      # ["$null"]
keyed_archive.top          # {"root"=>1}
keyed_archive.version      # 100000
keyed_archive.unpacked_top # {"root"=>nil}
```

### Unpacking keyed archive objects
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>$version</key>
  <integer>100000</integer>
  <key>$objects</key>
  <array>
    <string>$null</string>
    <dict>
      <key>key</key>
      <string>value</string>
    </dict>
  </array>
  <key>$archiver</key>
  <string>NSKeyedArchiver</string>
  <key>$top</key>
  <dict>
    <key>root</key>
    <dict>
      <key>CF$UID</key>
      <integer>1</integer>
    </dict>
  </dict>
</dict>
</plist>
```

```ruby
require 'keyed_archive'

keyed_archive = KeyedArchive.new(:file => "path/to/file.plist")
keyed_archive.objects             # ["$null", {"key"=>"value"}]
keyed_archive.top                 # {"root"=>1}
keyed_archive.unpacked_top()      # {"root"=>{"key"=>"value"}}
```

## Contributing

1. Fork it ( http://github.com/\<my-github-username\>/keyed_archive/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
