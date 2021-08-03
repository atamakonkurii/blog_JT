require 'rails_helper'

RSpec.describe User, type: :model do
  it 'name、email、password_diegestが正しくある場合、有効な状態であること' do

  end

  it 'nameが空の時無効な状態であること' do

  end

  it 'nameが30文字より多い時無効な状態であること' do

  end

  it 'emailが空の時無効な状態であること' do

  end

  it 'emailが重複していた場合無効な状態であること' do

  end

  it 'passwordが6文字未満の時無効な状態であること' do

  end

  it 'passwordが72文字より多い時無効な状態であること' do

  end
end
