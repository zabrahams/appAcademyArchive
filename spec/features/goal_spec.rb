# spec/features/goal_spec.rb

require 'spec_helper'


feature "create new goal" do
  let(:user) { create(:user) }
  before { signin(user.username, user.password) }

  scenario "has a new goal page" do
    visit new_goal_url
    expect(page).to have_content 'New Goal'
  end

  scenario "set a goal" do
    visit new_goal_url
    fill_in "Title", with: "New Diet"
    fill_in "Body", with: "Eat less in general"
    choose('Public')
    uncheck('Completed')
    click_button('Create')
    expect(page).to have_content 'New Diet'

  end
end

feature "show a goal" do
  let(:user) { create(:user) }
  before { signin(user.username, user.password) }

  let(:goal) { create(:completed_goal) }

  scenario "has a goal page" do
    visit goal_url(goal)
    expect(page).to have_content goal.title

  end

end

feature "edit a goal" do
  let(:user) { create(:user) }
  let(:goal) { create(:completed_goal) }
  let(:goal2) { create(:completed_goal, author_id: 2)}
  before { signin(user.username, user.password) }

  scenario "has goal edit page" do
      visit edit_goal_url(goal)
      expect(page).to have_content goal.title
      expect(page).to have_content "Edit Goal"
  end

  scenario "can only edit own goals" do
    visit edit_goal_url(goal2)
    expect(page).to have_content "You can't edit that goal!"
  end

end

feature "delete a goal" do
  let(:user) { create(:user) }
  let(:goal3) { create(:completed_goal, author_id: 2) }
  let(:goal) { create(:completed_goal) }
  before { signin(user.username, user.password) }


  scenario "can destroy only own goals" do
    visit goal_url(goal)
    click_button "Delete"
    expect(user.goals).to be_empty
  end

  scenario "can not destory other's goals" do
    visit goal_url(goal3)
    expect(page).to_not have_content "Delete"
  end
end
