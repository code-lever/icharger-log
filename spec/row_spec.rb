require 'spec_helper'

describe ICharger::Log::Row do

  subject { ICharger::Log::Row.new(data) }

  context 'channel 1, 6 cells' do

    let(:data) { '$1;1;18000;1;0;-53;23746;22752;1;380;0;3795;3793;3798;3795;3793;3789;0;0;0;0;50' }

    its(:channel) { should eql(1) }

    its(:current) { should be_within(0.01).of(-0.53) }

    its(:cell_count) { should eql(6) }

    it 'should have known cell voltages' do
      expect(subject.cell(0)).to be_within(0.01).of(3.79)
      expect(subject.cell(1)).to be_within(0.01).of(3.79)
      expect(subject.cell(2)).to be_within(0.01).of(3.79)
      expect(subject.cell(3)).to be_within(0.01).of(3.79)
      expect(subject.cell(4)).to be_within(0.01).of(3.79)
      expect(subject.cell(5)).to be_within(0.01).of(3.79)
    end

  end

  context 'channel 2, 6 cells' do

    let(:data) { '$2;1;9000;1;0;41;23840;22853;0;380;0;3810;3807;3813;3811;3806;3812;0;0;0;0;40' }

    its(:channel) { should eql(2) }

    its(:current) { should be_within(0.01).of(0.41) }

    its(:cell_count) { should eql(6) }

    it 'should have known cell voltages' do
      expect(subject.cell(0)).to be_within(0.01).of(3.81)
      expect(subject.cell(1)).to be_within(0.01).of(3.80)
      expect(subject.cell(2)).to be_within(0.01).of(3.81)
      expect(subject.cell(3)).to be_within(0.01).of(3.81)
      expect(subject.cell(4)).to be_within(0.01).of(3.80)
      expect(subject.cell(5)).to be_within(0.01).of(3.81)
    end

  end

  context 'channel 1, 10 cells' do

    let(:data) { '$1;1;106000;1;0;397;23840;22853;0;380;0;3810;3807;3813;3811;3806;3812;3811;3814;3809;3812;40' }

    its(:channel) { should eql(1) }

    its(:current) { should be_within(0.1).of(3.97) }

    its(:cell_count) { should eql(10) }

    it 'should have known cell voltages' do
      expect(subject.cell(0)).to be_within(0.01).of(3.81)
      expect(subject.cell(1)).to be_within(0.01).of(3.80)
      expect(subject.cell(2)).to be_within(0.01).of(3.81)
      expect(subject.cell(3)).to be_within(0.01).of(3.81)
      expect(subject.cell(4)).to be_within(0.01).of(3.80)
      expect(subject.cell(5)).to be_within(0.01).of(3.81)
      expect(subject.cell(6)).to be_within(0.01).of(3.81)
      expect(subject.cell(7)).to be_within(0.01).of(3.81)
      expect(subject.cell(8)).to be_within(0.01).of(3.80)
      expect(subject.cell(9)).to be_within(0.01).of(3.81)
    end

  end

  context 'channel 2, 2 cells' do

    let(:data) { '$2;1;87000;1;0;402;23840;22853;0;380;0;3810;3807;0;0;0;0;0;0;0;0;40' }

    its(:channel) { should eql(2) }

    its(:current) { should be_within(0.1).of(4.02) }

    its(:cell_count) { should eql(2) }

    it 'should have known cell voltages' do
      expect(subject.cell(0)).to be_within(0.01).of(3.81)
      expect(subject.cell(1)).to be_within(0.01).of(3.81)
    end

  end

end
