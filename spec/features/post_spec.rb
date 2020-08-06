require 'rails_helper'

describe 'navigate' do
  describe 'index' do
    before do
      @user = User.create(email: "test@email.com", password: "password", password_confirmation: "password", first_name: "John", last_name: "Doe")
      login_as(@user, :scope => :user)
      visit posts_path
    end
    it 'can be reached' do
        expect(page.status_code).to eq(200)
    end

    it 'has title of Time Entries' do
        expect(page).to have_content(/Time Entries/)
    end

    it 'has a list of times' do
      post1 = Post.create(date: Date.today, rationale: 'Post1', user_id: @user.id)
      expect(page).to have_content(/Post1/)
    end
  end

  describe 'creation' do
    before do
        user = User.create(email: "test@email.com", password: "password", password_confirmation: "password", first_name: "John", last_name: "Doe")
        login_as(user, :scope => :user)
        visit new_post_path
    end
    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created from new form page' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Some rationale"
      click_on 'Save'
      expect(page).to have_content("Some rationale")
    end

    it 'will have a user associated with it' do
        fill_in 'post[date]', with: Date.today
        fill_in 'post[rationale]', with: "User association"
        click_on 'Save'
        expect(User.last.posts.last.rationale).to eq("User association")
    end
  end
end