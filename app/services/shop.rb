require "net/http"
require "uri"
require "timeout"

module ShopService
  IMAGES_URL = "http://jsonplaceholder.typicode.com/photos"
  TODOS_URL = "http://jsonplaceholder.typicode.com/todos"
  IMAGES_COUNT = 5000

  MAX_REQUEST_TIMEOUT = 5 # seconds
  MAX_REQUEST_TRY_COUNT = 3

  def buy(customer, product)
    check_purchase(customer, product)

    photo = get_photo
    if correct_colors?(photo)
      PurchaseMailer.user_notification(customer, photo[:url])
    else
      PurchaseMailer.admins_notification(customer.user.email,
                                         get_todo(photo[:id])[:id])
    end
  end

  def check_purchase(customer, product)
    error_msg = ""
    if !customer.can_buy?
      error_msg = "Sorry, you can not make a purchase. Your email is invalid"
    elsif !product.can_purchase?
      error_msg = "This product can not be sold"
    end
    raise InternalError, error_msg if !error_msg.blank?
  end

  def get_photo
    Timeout::timeout(MAX_REQUEST_TIMEOUT) do
      api_request("#{IMAGES_URL}/#{photo_id}")
    end
  rescue Timeout::Error
    SystemMailer.api_error_notification
    raise WebApiError, "API request timeout"
  end

  def get_todo(id)
    try_count = 0
    begin
      Timeout::timeout(MAX_REQUEST_TIMEOUT) do
        api_request("#{TODOS_URL}/#{id}")
      end
    rescue Timeout::Error
      try_count += 1
      if try_count < MAX_REQUEST_TRY_COUNT
        retry
      else
        SystemMailer.api_error_notification
        raise WebApiError, "API request timeout"
      end
    end
  end

  def photo_id
    SecureRandom.random_number(IMAGES_COUNT)
  end

  def correct_colors?(photo)
    original_color = URI(photo[:url]).path.split("/").last.to_i(16)
    thumb_color = URI(photo[:thumbnailUrl]).path.split("/").last.to_i(16)
    original_color >= thumb_color
  end

  def api_request(url)
    sleep(rand 0..(MAX_REQUEST_TIMEOUT * 2))

    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    ActiveSupport::JSON.decode(response.body).symbolize_keys
  end
end

class Shop
  extend ShopService
end
