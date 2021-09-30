require 'rails_helper'

RSpec.describe User, type: :model do
  it "name、email、passwordが正しくある場合、有効な状態であること" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "重複したメールアドレスがある場合無効であること" do
    FactoryBot.create(:user, email: "aaaa@example.com")
    user = FactoryBot.build(:user, email: "aaaa@example.com")
    user.valid?
    expect(user.errors[:email]).to include("已經被使用")
  end

  it "passwordがnilの場合無効な状態であること" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("不能為空白")
  end
end
