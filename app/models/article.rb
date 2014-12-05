class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(tag_string)
    tag_names = tag_string.split(",")
      .map(&:strip)
      .map(&:downcase)
      .uniq

    new_or_found_tags = tag_names.map { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end

end
