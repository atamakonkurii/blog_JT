require 'rails_helper'

RSpec.describe User, type: :model do
  it 'name、email、password_diegestが正しくある場合、有効な状態であること' do
    user = User.new(
      name: "a" * 30,
      email: "test@example.com",
      password: "t" * 10
    )
    expect(user).to be_valid
  end

  it 'nameが空の時無効な状態であること' do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it 'nameが30文字より多い時無効な状態であること' do
    user = User.new(name: "a" * 31)
    user.valid?
    expect(user.errors[:name]).to include("は30文字以内で入力してください")
  end

  it 'emailが空の時無効な状態であること' do
    user = User.new(email: "")
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it 'emailが重複していた場合無効な状態であること' do
    User.create(
      name: "a" * 30,
      email: "test@example.com",
      password: "test0101"
    )
    user = User.new(
      name: "a" * 30,
      email: "test@example.com",
      password: "test0101"
    )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  it 'passwordが6文字未満の時無効な状態であること' do
    user = User.new(password: "a" * 7)
    user.valid?
    expect(user.errors[:password]).to include("は8文字以上で入力してください")
  end

  it 'passwordが72文字より多い時無効な状態であること' do
    user = User.new(password: "a" * 73)
    user.valid?
    expect(user.errors[:password]).to include("は72文字以内で入力してください")
  end
end
