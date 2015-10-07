require 'spec_helper'

describe Knowtify::Client do

  let(:client) { Knowtify::Client.new }

  it { expect(client.handler).to be_a(Knowtify::ExconHandler) }

  context "integration tests" do
    # tests assume ENV['KNOWTIFY_API_TOKEN'] is valid
    if ENV['KNOWTIFY_API_TOKEN']
      describe '#contacts_upsert' do
        it "should work" do
          resp = client.contacts_upsert(
            [
              {
                "name" => "John",
                "email" => "john@test.com",
                "data" => {
                  "category" => "sports",
                  "followers" => 300
                }
              },
              {
                "name" => "Samuel",
                "email" => "sam@test.com",
                "data" => {
                  "category" => "sports",
                  "followers" => 32,
                  "comments" => 54,
                  "role" => "Editor"
                }
              }
            ])
          expect(resp.body).to eql("{\"status\":\"received\",\"contacts\":2,\"successes\":2,\"errors\":0}")
        end
      end

      describe '#contacts_delete' do
        it "should work" do
          resp = client.contacts_delete(["john@test.com", "sam@test.com"])

          expect(resp.body).to eql("{\"status\":\"received\",\"contacts\":2,\"successes\":2,\"errors\":0}")
        end
      end

      describe '#global_edit' do
        it "should work" do
          resp = client.global_edit({"users"=>890, "comments"=>994, "top_story_url"=>"test.com/story", "top_story_title"=>"Article!"})
          expect(resp.body).to eql("{\"status\":\"received\",\"success\":true}")
        end
      end
    end
  end
end
