require 'spec_helper'

describe Mansion do
	before(:each) do
		@mansion = Mansion.new
	end

	it 'has a price' do
		@mansion.price = '20'
		expect(@mansion.price).to_not be_nil
	end

	it 'has a description' do
		@mansion.description = 'Hey'
		expect(@mansion.description).to_not be_nil
	end

	it 'has an address' do
		@mansion.address = 'Hey'
		expect(@mansion.address).to_not be_nil
	end

	it 'has a city' do
		@mansion.city = 'New York'
		expect(@mansion.city).to_not be_nil
	end

	it 'has bedrooms' do
		@mansion.bedrooms = 5
		expect(@mansion.bedrooms).to_not be_nil
	end

	it 'has bathrooms' do
		@mansion.bathrooms = 6
		expect(@mansion.bathrooms).to_not be_nil
	end

	it 'has square feet' do
    @mansion.square_feet = 500
		expect(@mansion.square_feet).to_not be_nil
	end
end
