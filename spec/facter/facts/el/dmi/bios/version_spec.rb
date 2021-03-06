# frozen_string_literal: true

describe Facts::El::Dmi::Bios::Version do
  describe '#call_the_resolver' do
    subject(:fact) { Facts::El::Dmi::Bios::Version.new }

    let(:version) { '6.00' }

    before do
      allow(Facter::Resolvers::Linux::DmiBios).to \
        receive(:resolve).with(:bios_version).and_return(version)
    end

    it 'calls Facter::Resolvers::Linux::DmiBios' do
      fact.call_the_resolver
      expect(Facter::Resolvers::Linux::DmiBios).to have_received(:resolve).with(:bios_version)
    end

    it 'returns a resolved fact' do
      expect(fact.call_the_resolver).to be_an_instance_of(Facter::ResolvedFact).and \
        have_attributes(name: 'dmi.bios.version', value: version)
    end
  end
end
