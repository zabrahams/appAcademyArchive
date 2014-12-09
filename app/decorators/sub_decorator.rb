class SubDecorator < Draper::Decorator
  # delegate_all

  def button_text
    object.persisted? ? "Update" : "Create"
  end

  def url2
    object.persisted? ? h.sub_url(object) : h.subs_url
  end

  def method
    object.persisted? ? "<input type='hidden' name='_method' value='PATCH'>" : ""
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
