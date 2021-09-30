require 'rails_helper'

RSpec.describe User, type: :model do
  it "name、email、passwordが正しくある場合、有効な状態であること" do
    user = User.new(
      name: "Kazuki",
      email: "test@example.com",
      password: "AaAa5555"
    )

    expect(user).to be_valid
  end

  it "passwordがnilの場合無効な状態であること" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("不能為空白")
  end
end
