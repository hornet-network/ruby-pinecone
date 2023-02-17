RSpec.describe Pinecone::Vectors do
  it "can be initialized" do
    expect { Pinecone::Vectors.new }.not_to raise_error
  end
end