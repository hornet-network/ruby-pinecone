# frozen_string_literal: true

RSpec.describe Pinecone do
  it "has a version number" do
    expect(Pinecone::VERSION).not_to be nil
  end

  describe "#configure" do
    let(:api_key) { "asdasdasd" }
    let(:base_uri) { "https://myproject.pinecone.io" }

    before do
      Pinecone.configure do |config|
        config.api_key = api_key
        config.base_uri = base_uri
      end
    end

    it "returns the config" do
      expect(Pinecone.configuration.api_key).to eq(api_key)
      expect(Pinecone.configuration.base_uri).to eq(base_uri)
    end

    context "without an API Key" do
      let(:api_key) { nil }

      it "raises an error" do
        expect { Pinecone::Client.new.query([1,0]) }.to raise_error(Pinecone::ConfigurationError)
      end
    end
  end
end
