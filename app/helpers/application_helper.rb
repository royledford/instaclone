module ApplicationHelper

  def title(page_title)
    if page_title.present?
      content_for :title, page_title.to_s
    else
      content_for :title, "InstaClone"
    end
  end

end
