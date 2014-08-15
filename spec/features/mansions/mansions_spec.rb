require 'spec_helper'

feature 'mansion selection' do
	m = Mansion.create
	scenario 'takes user to mansion show page' do
		visit mansions_path
		find('#mansionPhoto').click
		expect(current_path).to eq mansion_path
		expect(page).to have_content 'Now viewing mansion'
	end

end