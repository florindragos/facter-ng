# frozen_string_literal: true

describe Facts::Debian::SystemUptime::Hours do
  describe '#call_the_resolver' do
    subject(:fact) { Facts::Debian::SystemUptime::Hours.new }

    let(:value) { '2' }

    before do
      allow(Facter::Resolvers::Uptime).to receive(:resolve).with(:hours).and_return(value)
    end

    it 'calls Facter::Resolvers::Uptime' do
      fact.call_the_resolver
      expect(Facter::Resolvers::Uptime).to have_received(:resolve).with(:hours)
    end

    it 'returns hours since last boot' do
      expect(fact.call_the_resolver).to be_an_instance_of(Facter::ResolvedFact).and \
        have_attributes(name: 'system_uptime.hours', value: value)
    end
  end
end
