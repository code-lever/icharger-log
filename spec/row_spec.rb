require 'spec_helper'

describe ICharger::Log::Row do

  subject { ICharger::Log::Row.new(data) }

  context 'channel 1, 6 cells' do

    let(:data) { '$1;1;0;1;0;0;23773;22761;0;380;0;3797;3794;3796;3797;3795;3792;0;0;0;0;34' }

    its(:channel) { should eql(1) }

    its(:cell_count) { should eql(6) }

  end

  context 'channel 2, 6 cells' do

    let(:data) { '$2;1;9000;1;0;41;23840;22853;0;380;0;3810;3807;3813;3811;3806;3812;0;0;0;0;40' }

    its(:channel) { should eql(2) }

    its(:cell_count) { should eql(6) }

  end

  context 'channel 1, 10 cells' do

    let(:data) { '$1;1;9000;1;0;41;23840;22853;0;380;0;3810;3807;3813;3811;3806;3812;3811;3814;3809;3812;40' }

    its(:channel) { should eql(1) }

    its(:cell_count) { should eql(10) }

  end

  context 'channel 2, 2 cells' do

    let(:data) { '$2;1;9000;1;0;41;23840;22853;0;380;0;3810;3807;0;0;0;0;0;0;0;0;40' }

    its(:channel) { should eql(2) }

    its(:cell_count) { should eql(2) }

  end

end
