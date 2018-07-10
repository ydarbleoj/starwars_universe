RSpec.shared_examples "index example" do |parameter, url|
  it "returns http status code 200" do
      VCR.use_cassette(parameter) do
        get :index
        expect(response.code).to eq('200')
      end
    end

end