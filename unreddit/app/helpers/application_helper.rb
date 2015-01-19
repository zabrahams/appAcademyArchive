module ApplicationHelper

  def form_token
    "<input type='hidden' name='authenticity_token' value='#{form_authenticity_token}'>".html_safe
  end

  def button_text(thing)
    thing.persisted? ? "Edit #{thing.class}" : "Create #{thing.class}"
  end

  def method(thing)
    thing.persisted? ? "<input type='hidden' name='_method' value='PATCH'>".html_safe : ""
  end

end
