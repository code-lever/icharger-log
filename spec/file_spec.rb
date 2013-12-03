require 'spec_helper'

describe ICharger::Log::File do

  context 'data file LiPo[Storage_952_CH1].txt' do

    before(:all) { @file = ICharger::Log::File.new(data_file('LiPo[Storage_952_CH1].txt')) }

    subject { @file }

    it { should have(447).rows }

    its(:channel) { should eql(1) }

    its(:duration) { should be_within(0.1).of(44.6) }

    it { should have(447).milliseconds }

    it { should have(447).currents }

    it { should have(447).input_voltages }

    it { should have(447).pack_voltages }

    it { should have(447).capacities }

    its(:internal_temperatures?) { should be_true }

    it { should have(447).internal_temperatures }

    its(:external_temperatures?) { should be_false }

    its(:cell_count) { should eql(6) }

    it 'should have correct cell voltages count' do
      expect(subject.cell_voltages(0)).to have(447).items
      expect(subject.cell_voltages(1)).to have(447).items
      expect(subject.cell_voltages(2)).to have(447).items
      expect(subject.cell_voltages(3)).to have(447).items
      expect(subject.cell_voltages(4)).to have(447).items
      expect(subject.cell_voltages(5)).to have(447).items
    end

    it 'should have select cell voltages' do
      expect(subject.cell_voltages(0)[0]).to be_within(0.01).of(3.79)
      expect(subject.cell_voltages(1)[0]).to be_within(0.01).of(3.79)
      expect(subject.cell_voltages(2)[0]).to be_within(0.01).of(3.79)
      expect(subject.cell_voltages(3)[0]).to be_within(0.01).of(3.79)
      expect(subject.cell_voltages(4)[0]).to be_within(0.01).of(3.79)
      expect(subject.cell_voltages(5)[0]).to be_within(0.01).of(3.79)
      expect(subject.cell_voltages(0)[50]).to be_within(0.01).of(3.84)
      expect(subject.cell_voltages(1)[50]).to be_within(0.01).of(3.84)
      expect(subject.cell_voltages(2)[50]).to be_within(0.01).of(3.84)
      expect(subject.cell_voltages(3)[50]).to be_within(0.01).of(3.84)
      expect(subject.cell_voltages(4)[50]).to be_within(0.01).of(3.84)
      expect(subject.cell_voltages(5)[50]).to be_within(0.01).of(3.84)
    end

  end

  context 'data file LiPo[Storage_953_CH2].txt' do

    before(:all) { @file = ICharger::Log::File.new(data_file('LiPo[Storage_953_CH2].txt')) }

    subject { @file }

    it { should have(629).rows }

    its(:channel) { should eql(2) }

    its(:duration) { should be_within(0.1).of(62.8) }

  end

  context 'data file LiPo[Storage_965_CH2].txt' do

    before(:all) { @file = ICharger::Log::File.new(data_file('LiPo[Storage_965_CH2].txt')) }

    subject { @file }

    it { should have(868).rows }

    its(:channel) { should eql(2) }

    its(:duration) { should be_within(0.1).of(86.7) }

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
      files.should have(3).files

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
