RSpec.describe Pinecone::Vectors do
  it "can be initialized" do
    expect { Pinecone::Vectors.new(index: nil) }.not_to raise_error
  end
end