require 'rails_helper'
require 'support/factory_bot'

RSpec.describe 'Bookモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let!(:book) { build(:book, user_id: user.id) }
  
  context 'titleカラム' do
    it '空欄でないこと' do
      book.title = ''
      expect(book.valid?).to eq false;
    end
  end
end