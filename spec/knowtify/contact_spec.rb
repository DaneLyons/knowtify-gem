require 'spec_helper'
describe Knowtify::Contact do


  let(:valid_args) do
    {'name' => 'foo',
     'email' => 'foo@test.com',
     'data' => {'baz' => 1,
                'boo' => 2,
                'zap' => 3}
     }
  end

  context 'attr_accessors' do
    let(:contact) {Knowtify::Contact.new}

    describe '#email' do
      it "should ignore blank strings" do
        contact.email = " \t"
        expect(contact.email).to be_nil
      end
    end

    describe '#name' do
      it "should ignore blank strings" do
        contact.name = " \t"
        expect(contact.name).to be_nil
      end
    end

    describe '#data' do
      it "should ignore blank strings" do
        contact.data = " \t"
        expect(contact.data).to be_nil
      end
    end
  end

  context "initialized with JSON" do
    it "should work" do
      contact = Knowtify::Contact.new(valid_args.to_json)
      expect(contact.name).to eql(valid_args['name'])
      expect(contact.email).to eql(valid_args['email'])
      expect(contact.data).to eql(valid_args['data'])
    end
  end

  describe '#to_json' do
    it "should work" do
      contact = Knowtify::Contact.new(valid_args)
      expect(contact.to_json).to eql(valid_args.to_json)
    end
  end

  context 'validation' do
    context "email is blank" do
      it "should have error" do
        contact = Knowtify::Contact.new(:email => nil)
        expect(contact).to_not be_valid
        expect(contact.errors.length).to eql(1)
      end
    end
    context "response had authentication error" do
      it "should have error" do
        contact = Knowtify::Contact.new(valid_args)
        contact.response = Knowtify::Response.new
        contact.response.http_code = 401
        expect(contact).to_not be_valid
        expect(contact.errors.length).to eql(1)
      end
    end
    context "response shows action failed" do
      it "should have error" do
        contact = Knowtify::Contact.new(valid_args)
        contact.response = Knowtify::Response.new
        contact.response.http_code = 200
        contact.response.body = "{\"status\":\"received\",\"contacts\":1,\"successes\":0,\"errors\":1}"
        expect(contact).to_not be_valid
        expect(contact.errors.length).to eql(1)
      end
    end
  end
end
