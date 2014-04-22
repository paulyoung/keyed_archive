require 'cfpropertylist'

require "keyed_archive/unpacked_objects"
require "keyed_archive/version"

class KeyedArchive
  attr_accessor :archiver, :objects, :top, :version

  def initialize(file)
    plist = CFPropertyList::List.new(:file => file)
    data = CFPropertyList.native_types(plist.value)

    @archiver = data['$archiver']
    @objects = data['$objects']
    @top = data['$top']
    @version = data['$version']
  end
end
