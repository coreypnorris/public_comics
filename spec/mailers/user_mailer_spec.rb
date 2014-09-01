require "spec_helper"

describe UserMailer do
  describe "signup_confirmation" do
    let(:user) { FactoryGirl.create(:user)}
    let(:mail) { UserMailer.signup_confirmation(user) }

    it "renders the headers" do
      mail.subject.should eq("Sign Up Confirmation")
      mail.to.should eq(["#{user.email}"])
      mail.from.should eq(["admin@publiccomics.herokuapp.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Thank you for signing up.")
    end
  end

  describe "forgotton password" do
    let(:user) { FactoryGirl.create(:user)}
    let(:mail) { UserMailer.reset_password_instructions(user) }

    it "renders the headers" do
      mail.subject.should eq("Reset password instructions")
      mail.to.should eq(["#{user.email}"])
      mail.from.should eq(["admin@publiccomics.herokuapp.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Someone has requested a link to change your password. You can do this through the link below.")
    end
  end

end
