$: << File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib')
require 'algorithms'

describe "empty trie" do
  before(:each) do
    @trie = Containers::Trie.new
  end

  it "should not get or has_key?" do
    expect(@trie.get("anything")).to eq(nil)
    expect(@trie.has_key?("anything")).to eq(false)
  end

  it "should not have longest_prefix or match wildcards" do
    expect(@trie.wildcard("an*thing")).to eql([])
    expect(@trie.longest_prefix("an*thing")).to eql("")
  end
end

describe "non-empty trie" do
  before(:each) do
    @trie = Containers::Trie.new
    @trie.push("Hello", "World")
    @trie.push("Hilly", "World")
    @trie.push("Hello, brother", "World")
    @trie.push("Hello, bob", "World")
  end

  it "should has_key? keys it has" do
    expect(@trie.has_key?("Hello")).to eq(true)
    expect(@trie.has_key?("Hello, brother")).to eq(true)
    expect(@trie.has_key?("Hello, bob")).to eq(true)
  end

  it "should not has_key? keys it doesn't have" do
    expect(@trie.has_key?("Nope")).to eq(false)
  end

  it "should get values" do
    expect(@trie.get("Hello")).to eq(["World"])
  end

  it "should concat values" do
    @trie.push("Hello", "John")
    expect(@trie.get("Hello")).to eq(%w[World John])
  end

  it "should return longest prefix" do
    expect(@trie.longest_prefix("Hello, brandon")).to eq("Hello")
    expect(@trie.longest_prefix("Hel")).to eq("")
    expect(@trie.longest_prefix("Hello")).to eq("Hello")
    expect(@trie.longest_prefix("Hello, bob")).to eq("Hello, bob")
  end

  it "should match wildcards" do
    expect(@trie.wildcard("H*ll.")).to eq(["Hello", "Hilly"])
    expect(@trie.wildcard("Hel")).to eq([])
  end


end


describe "prefix with trie" do
  before(:each) do
    @trie = Containers::Trie.new
    @trie.push("scott", 1)
    @trie.push("sco", 2)
    @trie.push("scottie", 3)
  end

  it "should match prefix" do
    expect(@trie.with_prefix("sco")).to eq([1,2,3])
    expect(@trie.with_prefix("scot")).to eq([1,3])
    expect(@trie.with_prefix("abc")).to eq([])
  end


end