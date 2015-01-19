class UserDecorator < Draper::Decorator
  delegate_all

  def button_text
  end

  def form_path
  end

end
