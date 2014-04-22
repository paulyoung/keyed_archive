require "keyed_archive/unpacked_objects"

shared_examples "unpack" do
  it "should unpack objects" do
    keyed_archive = KeyedArchive.new(filename)
    unpacked_objects = keyed_archive.unpacked_objects()
    fixture_archive = KeyedArchive.new(fixture)
    expect(unpacked_objects).to eq(fixture_archive.objects)
  end
end

describe KeyedArchive, "#unpack" do
  context "single reference" do
    it_behaves_like "unpack" do
      let(:filename) { "spec/fixtures/single_object_reference.plist" }
      let(:fixture) { "spec/fixtures/single_object_reference_unpacked.plist" }
    end
  end

  context "double reference" do
    it_behaves_like "unpack" do
      let(:filename) { "spec/fixtures/double_object_reference.plist" }
      let(:fixture) { "spec/fixtures/double_object_reference_unpacked.plist" }
    end
  end
end

