require 'spec_helper'

describe PersonalityTrait do
  it 'has a name' do
    @personality_trait = PersonalityTrait.create(
      name: 'quiet',
      category: 'about'
    )
    expect(@personality_trait.name).to eq 'quiet'
  end

  
end
