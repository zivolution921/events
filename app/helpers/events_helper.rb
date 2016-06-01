module EventsHelper
  def format_price(event)
    if event.free?
      # built in helper generate tag for html with string free
      content_tag(:strong, 'Free')
    else
      # built in method to convert currency
      number_to_currency(event.price)
    end
  end
  
  def image_for(event)
    if event.image_file_name.blank?
      image_tag 'placeholder.png'
    else
      image_tag event.image_file_name
    end
  end
end
