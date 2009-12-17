require 'test/test_helper.rb'

class UserStoriesTest < ActionController::IntegrationTest
  fixtures :all

  # Replace this with your real tests.
  def test_buying_a_product
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby_book)
    
    get "/store/index"
    assert_response :success
    assert_template "index"
    
    xml_http_request :put, "/store/add_to_cart", :id => ruby_book.id
    assert_response :success
    
    post "/store/checkout"
    assert_response :success
    assert_template "checkout"
    
    post_via_redirect "/store/save_order",
                      :order => { :name       => "Dave Thomas",
                                  :address    => "123 The Street",
                                  :email      => "dave@pragprog.com",
                                  :pay_type   => "check"
                                }
    assert_response :success
    assert_template "index"
    assert_equal 0, session[:cart].items.size
    
    orders = Order.find(:all)
    assert_equal 1, orders.size
    order = orders[0]
    
    assert_equal "Dave Thomas", order.name
    assert_equal "123 The Street", order.address
    assert_equal "dave@pragprog.com", order.email
    assert_equal "check", order.pay_type
    
    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product
  end
end
