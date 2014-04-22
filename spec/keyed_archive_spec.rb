require "keyed_archive"

describe KeyedArchive, "#initialize" do
  let(:filename) { 'spec/fixtures/empty.plist' }

  it "should create an instance" do
    keyed_archive = KeyedArchive.new(filename)
    expect(keyed_archive).to be_instance_of(KeyedArchive)
  end

  it "should set the archiver" do
    keyed_archive = KeyedArchive.new(filename)
    expect(keyed_archive.archiver).to be_a(String)
  end

  it "should set the objects" do
    keyed_archive = KeyedArchive.new(filename)
    expect(keyed_archive.objects).to be_an(Array)
  end

  it "should set the top" do
    keyed_archive = KeyedArchive.new(filename)
    expect(keyed_archive.top).to be_a(Hash)
  end

  it "should set the version" do
    keyed_archive = KeyedArchive.new(filename)
    expect(keyed_archive.version).to be_an(Integer)
  end
end
