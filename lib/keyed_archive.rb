require 'cfpropertylist'

require 'keyed_archive/unpacked_objects'
require 'keyed_archive/version'

class KeyedArchive
  attr_accessor :archiver, :objects, :top, :version

  # 
  # Take the same sort of arguments as CFPropertyList
  # :file => filename to load
  # :data => variable with the data to load directly
  def initialize(opts={})
    blob = opts[:data]
    filename = opts[:file]

    plist = CFPropertyList::List.new(:file => filename) unless filename.nil? or !File.exists?(filename)
    plist = CFPropertyList::List.new(:data => blob) unless blob.nil? or blob.length < 1

    if !plist.nil?
      data = CFPropertyList.native_types(plist.value)

      @archiver = data['$archiver']
      @objects = data['$objects']
      @top = data['$top']
      @version = data['$version']
    else
      raise "Plist not created"
    end
  end
end
