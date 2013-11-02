require 'spec_helper'

describe ICharger::Log::Row do

  subject { ICharger::Log::Row.new(data) }

  context 'channel 1, 6 cells' do

    let(:data) { '$1;1;18000;1;0;-53;23746;22752;1;391;0;3795;3793;3798;3795;3793;3789;0;0;0;0;50' }

    its(:channel) { should eql(1) }

    its(:state) { should eql('charging') }

    its(:current) { should be_within(0.01).of(-0.53) }

    its(:input_voltage) { should be_within(0.1).of(23.75) }

    its(:pack_voltage) { should be_within(0.1).of(22.75) }

    its(:capacity) { should be_within(0.1).of(0.1) }

    it 'should have internal temperatures' do
      expect(subject.internal_temperature(:c)).to be_within(0.1).of(39.1)
      expect(subject.internal_temperature(:f)).to be_within(0.1).of(102.4)
    end

    its(:cell_count) { should eql(6) }

    it 'should have known cell voltages' do
      expect(subject.cell_voltage(0)).to be_within(0.01).of(3.79)
      expect(subject.cell_voltage(1)).to be_within(0.01).of(3.79)
      expect(subject.cell_voltage(2)).to be_within(0.01).of(3.79)
      expect(subject.cell_voltage(3)).to be_within(0.01).of(3.79)
      expect(subject.cell_voltage(4)).to be_within(0.01).of(3.79)
      expect(subject.cell_voltage(5)).to be_within(0.01).of(3.79)
    end

  end

  context 'channel 2, 6 cells' do

    let(:data) { '$2;1;9000;1;0;41;23840;22853;0;380;0;3810;3807;3813;3811;3806;3812;0;0;0;0;40' }

    its(:channel) { should eql(2) }

    its(:state) { should eql('charging') }

    its(:current) { should be_within(0.01).of(0.41) }

    its(:input_voltage) { should be_within(0.1).of(23.84) }

    its(:pack_voltage) { should be_within(0.1).of(22.85) }

    its(:capacity) { should be_within(0.1).of(0.0) }

    it 'should have internal temperatures' do
      expect(subject.internal_temperature(:c)).to be_within(0.1).of(38.0)
      expect(subject.internal_temperature(:f)).to be_within(0.1).of(100.4)
    end

    its(:cell_count) { should eql(6) }

    it 'should have known cell voltages' do
      expect(subject.cell_voltage(0)).to be_within(0.01).of(3.81)
      expect(subject.cell_voltage(1)).to be_within(0.01).of(3.80)
      expect(subject.cell_voltage(2)).to be_within(0.01).of(3.81)
      expect(subject.cell_voltage(3)).to be_within(0.01).of(3.81)
      expect(subject.cell_voltage(4)).to be_within(0.01).of(3.80)
      expect(subject.cell_voltage(5)).to be_within(0.01).of(3.81)
    end

  end

  context 'channel 1, 10 cells' do

    let(:data) { '$1;2;106000;1;0;397;23760;22853;-601;380;0;3810;3807;3813;3811;3806;3812;3811;3814;3809;3812;40' }

    its(:channel) { should eql(1) }

    its(:state) { should eql('discharging') }

    its(:current) { should be_within(0.1).of(3.97) }

    its(:input_voltage) { should be_within(0.1).of(23.76) }

    its(:pack_voltage) { should be_within(0.1).of(22.85) }

    its(:capacity) { should be_within(0.1).of(-6.01) }

    it 'should have internal temperatures' do
      expect(subject.internal_temperature(:c)).to be_within(0.1).of(38.0)
      expect(subject.internal_temperature(:f)).to be_within(0.1).of(100.4)
    end

    its(:cell_count) { should eql(10) }

    it 'should have known cell voltages' do
      expect(subject.cell_voltage(0)).to be_within(0.01).of(3.81)
      expect(subject.cell_voltage(1)).to be_within(0.01).of(3.80)
      expect(subject.cell_voltage(2)).to be_within(0.01).of(3.81)
      expect(subject.cell_voltage(3)).to be_within(0.01).of(3.81)
      expect(subject.cell_voltage(4)).to be_within(0.01).of(3.80)
      expect(subject.cell_voltage(5)).to be_within(0.01).of(3.81)
      expect(subject.cell_voltage(6)).to be_within(0.01).of(3.81)
      expect(subject.cell_voltage(7)).to be_within(0.01).of(3.81)
      expect(subject.cell_voltage(8)).to be_within(0.01).of(3.80)
      expect(subject.cell_voltage(9)).to be_within(0.01).of(3.81)
    end

  end

  context 'channel 2, 2 cells' do

    let(:data) { '$2;1;87000;1;0;402;23840;22853;150;380;0;3810;3807;0;0;0;0;0;0;0;0;40' }

    its(:channel) { should eql(2) }

    its(:state) { should eql('charging') }

    its(:time) { should eql(87000) }

    its(:current) { should be_within(0.1).of(4.02) }

    its(:input_voltage) { should be_within(0.1).of(23.84) }

    its(:pack_voltage) { should be_within(0.1).of(22.85) }

    its(:capacity) { should be_within(0.1).of(1.5) }

    it 'should have internal temperatures' do
      expect(subject.internal_temperature(:c)).to be_within(0.1).of(38.0)
      expect(subject.internal_temperature(:f)).to be_within(0.1).of(100.4)
    end

    its(:cell_count) { should eql(2) }

    it 'should have known cell voltages' do
      expect(subject.cell_voltage(0)).to be_within(0.01).of(3.81)
      expect(subject.cell_voltage(1)).to be_within(0.01).of(3.81)
    end

  end

end
