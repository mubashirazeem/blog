module ApplicationHelper
  include Pagy::Frontend

  # def truncate_words(text, limit)
  #   description_plain_text = text&.to_plain_text
  #   return if description_plain_text.nil?
  
  #   truncate_words(description_plain_text, length: limit)
  # end

  def truncate_words(text, limit)
    return if text.nil?

    plain_text = text.body.to_plain_text
    truncate(plain_text, length: limit)
  end

end
