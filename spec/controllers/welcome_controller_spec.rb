require 'spec_helper'

RSpec.describe WelcomeController, :type => :controller do

  describe "#index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end
  end

end
