# frozen_string_literal: true

describe 'Macosx DmiProductName' do
  context '#call_the_resolver' do
    it 'returns a fact' do
      expected_fact = double(Facter::ResolvedFact, name: 'dmi.product.name', value: 'MacBookPro11,4')
      allow(Facter::Resolvers::Macosx::DmiBios).to receive(:resolve).with(:model).and_return('MacBookPro11,4')
      allow(Facter::ResolvedFact).to receive(:new).with('dmi.product.name', 'MacBookPro11,4').and_return(expected_fact)

      fact = Facter::Macosx::DmiProductName.new
      expect(fact.call_the_resolver).to eq(expected_fact)
    end
  end
end
