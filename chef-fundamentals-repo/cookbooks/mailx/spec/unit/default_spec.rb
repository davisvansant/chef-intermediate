require_relative '../spec_helper'

describe 'mailx::default' do
  context 'on Debian' do
    let(:chef_run) { ChefSpec::Runner.new({:platform => 'ubuntu', :version => '14.04' }).converge(described_recipe) }

    it 'should install the correct packages' do
      expect(chef_run).to install_package 'mailutils'
    end
  end

  context 'on CentOS' do
    let(:chef_run) { ChefSpec::Runner.new({:platform => 'centos', :version => '6.5'}).converge(described_recipe) }

    it 'should install the correct packages' do
      expect(chef_run).to install_package 'mailx'
    end
  end
end
