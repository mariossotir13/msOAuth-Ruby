module ApplicationHelper

  # @param [String] page_title
  # @return [String]
  def full_title(page_title)
    base_title = 'MsOAuth'
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end
