# frozen_string_literal: true

describe Facts::Debian::Processors::Count do
  describe '#call_the_resolver' do
    subject(:fact) { Facts::Debian::Processors::Count.new }

    let(:processors_count) { '4' }

    before do
      allow(Facter::Resolvers::Linux::Processors).to \
        receive(:resolve).with(:processors).and_return(processors_count)
    end

    it 'calls Facter::Resolvers::Linux::Processors' do
      fact.call_the_resolver
      expect(Facter::Resolvers::Linux::Processors).to have_received(:resolve).with(:processors)
    end

    it 'returns a resolved fact' do
      expect(fact.call_the_resolver).to be_an_instance_of(Facter::ResolvedFact).and \
        have_attributes(name: 'processors.count', value: processors_count)
    end
  end
end
