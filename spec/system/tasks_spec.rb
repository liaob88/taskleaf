require 'rails_helper'

describe 'タスク管理機能', type: :system do

  let!(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let!(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:user_a_task) { FactoryBot.create(:task, name: 'A_test-task', user: user_a) }
  
  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end
  
  shared_examples_for 'display user_a task' do
    it { expect(page).to have_content 'A_test-task' }
  end

  describe 'index' do
    context 'logged in as user_a' do
      let(:login_user) { user_a }
      it_behaves_like 'display user_a task'
    end

    context 'logged in as user_b' do
      let(:login_user) { user_b }

      it 'display no user_a task' do
        expect(page).to have_no_content 'A_test-task'
      end
    end

  end

  describe '詳細表示機能' do
    context 'logged in as user_a' do
      let(:login_user) { user_a }

      before do
        visit task_path(user_a_task)
      end

      it_behaves_like 'display user_a task'
    end
  end

  describe '新規作成' do
    let(:login_user) { user_a }

    before do
      visit new_task_path
      fill_in "名前",	with: task_name
      click_button '登録する'
    end

    context 'valid text name' do
      let(:task_name) { 'test task' }

      it 'タスクの新規作成を正しく行える' do
        expect(page).to have_selector '.alert-success', text: "タスク「test task」を登録しました"
      end
    end

    context 'invalid text name' do
      let(:task_name) { '' }

      it 'error' do
        within '#error_explanation' do
          expect(page).to have_content '名前を入力してください'
        end
      end
    end
  end
end