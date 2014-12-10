require "spec_helper"

feature "make a comment" do
  let(:user) { create(:user) }
  let(:goal) { create(:completed_goal) }
  before { signin(user.username, user.password) }

  scenario "user has a comment form" do
    visit user_url(user)
    expect(page).to have_content("Post Comment")
  end

  scenario "goal has a comment form" do
    visit goal_url(goal)
    expect(page).to have_content("Post Comment")
  end

  scenario "can add comments to users" do
    visit user_url(user)
    fill_in 'Body', with: "You rock!"
    click_button "Post Comment"
    visit user_url(user)
    expect(page).to have_content("You rock!")
  end

  scenario "can add comments to goals" do
    visit goal_url(goal)
    fill_in 'Body', with: "Your goal rocks!"
    click_button "Post Comment"
    visit goal_url(goal)
    expect(page).to have_content("Your goal rocks!")
  end

end

feature "delete a comment" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, username: 'Blargh', id: 2)}
  let(:user_comment) { user.comment.create(body: "I am a comment",
                                           commentable_id: 1,
                                           commentable_type: "User") }
  let(:other_comment) { other_user.comment.create(body: "Tired!! so tired....",
                                                  commentable_id: 1,
                                                  commentable_type: "User") }
  before { signin(user.username, user.password) }

  scenario "comment author can delete comment" do
    visit user_url(user)
    click_button "Delete"
    expect(user.comments).to be_empty
  end

  scenario "nonauthor can not delete comment" do
    visit user_url(other_user)
    expect(page).to_not have_content("Delete")
  end

end

feature "edit a comment" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, username: 'Blargh', id: 2)}
  let(:user_comment) { user.comment.create(body: "I am a comment",
                                           commentable_id: 1,
                                          commentable_type: "User") }
  let(:other_comment) { other_user.comment.create(body: "Tired!! so tired....",
                                                  commentable_id: 1,
                                                  commentable_type: "User") }
  before { signin(user.username, user.password) }

  scenario "comment has an edit page" do
    visit edit_comment_url(user_comment)
    expect(page).to have_content("Edit Comment")
  end

  scenario "author can edit comment" do
    visit edit_comment_url(user_comment)
    fill_in "Body", with: "Anything"
    click_button "Edit Comment"
    visit user_url(user)
    expect(page).to have_content("Anything")
  end

  scenario "nonauthor can not edit comment" do
    visit edit_comment_url(other_comment)
    expect(page).to have_content("You can't edit that comment")
  end

end
