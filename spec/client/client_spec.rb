RSpec.describe Pinecone::Client do
  it "can be initialized" do
    expect { Pinecone::Client.new }.not_to raise_error
  end
end