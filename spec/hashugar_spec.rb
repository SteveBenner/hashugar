require 'spec_helper'
# todo: add tests for additions since v0.0.7

describe Hashugar do
  context 'when accessing simple hash' do
    it 'should be make accessible string and symbol keys' do
      hashugar = {:a => 1, 'b' => 2}.to_hashugar
      hashugar.a.should == 1
      hashugar.b.should == 2
    end

    it 'should be readable through nice methods' do
      hashugar = {:a => 1, :b => 2}.to_hashugar
      hashugar.a.should == 1
      hashugar.b.should == 2
    end

    it 'should be writable through nice methods' do
      hashugar = {:a => 1}.to_hashugar
      hashugar.a = 2
      hashugar.b = 3
      hashugar.a.should == 2
      hashugar.b.should == 3
    end

    it 'should be readable through old methods' do
      hashugar = {:a => 1}.to_hashugar
      hashugar[:a].should == 1
      hashugar['a'].should == 1
    end

    it 'should be writable through old methods' do
      hashugar = {:a => 1}.to_hashugar
      hashugar['a'] = 2
      hashugar.a.should == 2
      hashugar[:a] = 3
      hashugar.a.should == 3
    end
  end

  context 'when accessing nested hash' do
    it 'should be writable through nice methods' do
      hashugar = {:a => {:b => 1}}.to_hashugar
      hashugar.a.b.should == 1
    end

    it 'should be writable through nice methods' do
      hashugar = {:a =>{}}.to_hashugar
      hashugar.a.b = 1
      hashugar.a.b.should == 1
    end
  end

  context 'when accessing hashes in array' do
    it 'should return hashugars' do
      hashugar = [{:a => 1}, {:b => 2}].to_hashugar
      hashugar[0].a.should == 1
      hashugar.last.b.should == 2
    end
  end

  context 'when using respond_to?' do
    it 'should return true on valid key' do
      hashugar = {:a => 1}.to_hashugar
      hashugar.respond_to?('a').should be_true
      hashugar.respond_to?(:a).should be_true
      hashugar.respond_to?(:b).should be_false
    end
  end

  context 'when creating using Hashugar#new' do
    it 'should accept hash in contructor' do
      hashugar = Hashugar.new({:a => {:b => 1}})
      hashugar.a.b.should == 1
    end
  end

  context 'when enumerating' do
    it 'should act like normal hash' do
      hashugar = Hashugar.new({:a => 4, :c => 2})

      keys = []
      values = []
      hashugar.each do |k, v|
        keys << k
        values << v
      end

      keys.should == [:a, :c]
      values.should == [4, 2]
    end
  end
end