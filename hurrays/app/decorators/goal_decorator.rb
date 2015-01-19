class GoalDecorator < Draper::Decorator
  delegate_all

  def button_text
    object.persisted? ? "Update" : "Create"
  end

  def url
    object.persisted? ? h.goal_url(object) : h.goals_url
  end

  def method
    object.persisted? ? "<input type='hidden' name='_method' value='Patch'>".html_safe : ""
  end
end
