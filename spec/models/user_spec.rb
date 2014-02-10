require 'spec_helper'

describe User do

  let(:user) { Factory(:user, first_name: "John", last_name: "Doe") }

	context "validations" do
		
    let!(:user) {Factory(:user)}

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

  end

  context "attributes" do

    it "should have a name attribute" do
      user.should respond_to(:name)
    end

    it "should have the right name" do
      user.name.should eq('John Doe')
    end

 end

  context "avatar attributes" do

    %w(avatar_image retained_avatar_image remove_avatar_image).each do |attr|
      it { should respond_to(attr.to_sym) }
    end

    %w(avatar_image retained_avatar_image remove_avatar_image).each do |attr|
      it { should allow_mass_assignment_of(attr.to_sym) }
    end

    it "should validate the file size of the avatar" do
      user.avatar_image = Rails.root + 'spec/fixtures/huge_size_avatar.jpg'
      user.should_not be_valid # 200 KB
    end

    it "should validate the format of the avatar" do
      user.avatar_image = Rails.root + 'spec/fixtures/dummy.txt'
      user.should_not be_valid
    end

  end

end