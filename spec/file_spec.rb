require 'spec_helper'

describe ICharger::Log::File do

  context 'data file LiPo[Storage_952_CH1].txt' do

    before(:all) { @file = ICharger::Log::File.new(data_file('LiPo[Storage_952_CH1].txt')) }

    subject { @file }

    its(:channel) { should eql(1) }

    its(:duration) { should be_within(0.1).of(44.6) }

  end

  context 'data file LiPo[Storage_953_CH2].txt' do

    before(:all) { @file = ICharger::Log::File.new(data_file('LiPo[Storage_953_CH2].txt')) }

    subject { @file }

    its(:channel) { should eql(2) }

    its(:duration) { should be_within(0.1).of(62.8) }

  end

  describe '#icharger?' do

    it 'should be false for invalid or missing files' do
      files = invalid_data_files
      files.should have(2).files

      files.each do |f|
        expect(ICharger::Log::File.icharger?(f)).to be_false
      end
    end

    it 'should be true for valid files' do
      files = data_files
      files.should have(2).files

      files.each do |f|
        expect(ICharger::Log::File.icharger?(f)).to be_true
      end
    end

    it 'should return a file object' do
      expect(ICharger::Log::File.icharger?(data_files[0])).to be_a(ICharger::Log::File)
    end

    it 'should return nil when invalid' do
      expect(ICharger::Log::File.icharger?(invalid_data_files[0])).to be_nil
    end

  end

end
