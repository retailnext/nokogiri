require File.join(File.dirname(__FILE__), '..', 'helper')

include Nokogiri::XML

describe Nokogiri::XML::Reader do
  
  it "should return the correct local_names" do
    xml = <<-oexml
    <x xmlns:tenderlove='http://tenderlovemaking.com/'>
      <tenderlove:foo awesome='true'>snuggles!</tenderlove:foo>
    </x>
    oexml
    r = Reader.from_memory(xml)
    r.should_not be_nil
    r.map{|x| x.local_name}.should == ["x","#text","foo","#text","foo","#text","x"]
  end

  it "should return the correct names" do
    reader = Nokogiri::XML::Reader.from_memory(<<-eoxml)
    <x xmlns:edi='http://ecommerce.example.org/schema'>
      <edi:foo>hello</edi:foo>
    </x>
    eoxml
    reader.should_not be_nil
    reader.map{|x| x.name}.should == ["x", "#text", "edi:foo", "#text", "edi:foo", "#text", "x"]
  end

  it "should set io as source when called from_io method" do
    io = StringIO.new(<<-eoxml)
    <x xmlns:tenderlove='http://tenderlovemaking.com/'>
      <tenderlove:foo awesome='true'>snuggles!</tenderlove:foo>
    </x>
    eoxml
    reader = Nokogiri::XML::Reader.from_io(io)
    reader.source.should be_equal(io)
  end
end
