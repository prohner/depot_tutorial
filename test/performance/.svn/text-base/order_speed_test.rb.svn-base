require 'test/test_helper'
#require 'test/functional/store_controller'
require 'store_controller'

class StoreController; def rescue_action(e) raise e end; end

class OrderSpeedTest < ActionController::TestCase
  self.fixture_path = "test/performance"
  fixtures :products
  
  DAVES_DETAILS = {
    :name     => "Dave Thomas",
    :address  => "123 The Street",
    :email    => "date@pragprog.com",
    :pay_type => "check"
  }
  def setup
    @controller = StoreController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  def test_100_orders
    Order.delete_all
    LineItem.delete_all
    
    @controller.logger.silence do
      elapsed_time = Benchmark.realtime do
        100.downto(1) do |prd_id|
          cart = Cart.new
          product = Product.find(2)
          
          assert product
          cart.add_product(product)
          post :save_order,
               { :order => DAVES_DETAILS },
               { :cart => cart } 
          assert_redirected_to :action => :index
        end
      end
      
      assert_equal 100, Order.count
      assert elapsed_time < 3.00
    end
  end
end
