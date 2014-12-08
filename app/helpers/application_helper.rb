module ApplicationHelper

  def authenticity_token

    auth_string = <<-HTML
    <input type="hidden"
           name="authenticity_token"
           value="#{form_authenticity_token}">
    HTML

    auth_string.html_safe
  end

  def ugly_lyrics(lyrics)
    lyrics = lyrics
              .split("\n")
              .map { |line| "&#9835 #{h(line)}"}
              .join("\n")
    "<pre>#{lyrics}</pre>".html_safe
  end
end
