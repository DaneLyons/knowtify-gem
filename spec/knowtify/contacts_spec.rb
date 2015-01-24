require 'spec_helper'
describe Knowtify::Contacts do


  let(:valid_contact_hash) do
    {'name' => 'foo',
     'email' => 'foo@test.com',
     'data' => {'baz' => 1,
                'boo' => 2,
                'zap' => 3}
     }
  end

  let(:invalid_contact_hash) do
    {'name' => 'foo',
     'email' => '',
     'data' => {'baz' => 1,
                'boo' => 2,
                'zap' => 3}
     }
  end

  let(:valid_contact) { Knowtify::Contact.new(valid_contact_hash) }

  let(:invalid_contact) { Knowtify::Contact.new(invalid_contact_hash) }

  let(:valid_args) { [valid_contact] }

  let(:invalid_args) { [invalid_contact, valid_contact] }

  describe '#initialize' do
    context "with Knowtify::Contacts" do
      let(:contacts) {Knowtify::Contacts.new(invalid_args)}

      context 'valid contacts' do
        it { expect(contacts.contacts.include?(valid_contact)).to eql(true) }
        it { expect(contacts.invalid_contacts.include?(valid_contact)).to eql(false) }
      end

      context 'invalid contacts' do
        it { expect(contacts.contacts.include?(invalid_contact)).to eql(false) }
        it { expect(contacts.invalid_contacts.include?(invalid_contact)).to eql(true) }
      end

    end

    context " with JSON" do

      let(:contacts) { Knowtify::Contacts.new([valid_contact_hash,invalid_contact_hash].to_json) }

      it { expect(contacts.contacts.length).to eql(1) }
      it { expect(contacts.invalid_contacts.length).to eql(1) }
    end
  end

  describe '#to_json' do
    it 'should to work' do 
    	contact = Knowtify::Contacts.new(invalid_args)
    	expect(contact.to_json).to eql({'contacts' => [valid_contact_hash]}.to_json) 
    end
  end

  context 'validation' do
  	let(:contacts) { Knowtify::Contacts.new(invalid_args) }
  	context "config.ingore_invalid_contacts = true" do
  		it {
  			Knowtify::Config.any_instance.stub(:ingore_invalid_contacts?).and_return(true)
  			expect(contacts).to be_valid
  		}
    end
    context "config.ingore_invalid_contacts = true" do
  		it {
  			Knowtify::Config.any_instance.stub(:ingore_invalid_contacts?).and_return(false)
  			expect(contacts).to_not be_valid
  		}
    end
    context "response had authentication error" do
      it "should have error" do
        contact = Knowtify::Contacts.new(valid_args)
        contact.response = Knowtify::Response.new
        contact.response.http_code = 401
        expect(contact).to_not be_valid
        expect(contact.errors.length).to eql(1)
      end
    end
    context "response shows action failed" do
      it "should have error" do
        contact = Knowtify::Contacts.new(valid_args)
        contact.response = Knowtify::Response.new
        contact.response.http_code = 200
        contact.response.body = "{\"status\":\"received\",\"contacts\":1,\"successes\":0,\"errors\":1}"
        expect(contact).to_not be_valid
        expect(contact.errors.length).to eql(1)
      end
    end
  end
end
