# frozen_string_literal: true

describe Facts::Debian::Memory::Swap::AvailableBytes do
  describe '#call_the_resolver' do
    subject(:fact) { Facts::Debian::Memory::Swap::AvailableBytes.new }

    let(:value) { 2_332_425 }

    before do
      allow(Facter::Resolvers::Linux::Memory).to \
        receive(:resolve).with(:swap_free).and_return(value)
    end

    it 'calls Facter::Resolvers::Linux::Memory' do
      fact.call_the_resolver
      expect(Facter::Resolvers::Linux::Memory).to have_received(:resolve).with(:swap_free)
    end

    it 'returns a resolved fact' do
      expect(fact.call_the_resolver).to be_an_instance_of(Facter::ResolvedFact).and \
        have_attributes(name: 'memory.swap.available_bytes', value: value)
    end
  end
end
