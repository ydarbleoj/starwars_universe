RSpec.shared_examples "index example" do |parameter|
  def response_body
    JSON.parse(response.body)
  end

  it "has an http response code of 200" do
    obj = VCR.use_cassette(parameter) do
      get :index, xhr: true
      expect(response.code).to eq('200')
    end
  end

  it "has correct keys" do
    VCR.use_cassette(parameter) do
      get :index, xhr: true

      res = response_body
      expect(res).to have_key('next')
      expect(res).to have_key('previous')
      expect(res).to have_key('results')
    end
  end

end