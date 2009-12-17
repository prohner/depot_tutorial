require 'test/test_helper.rb'

class ProductTest < ActiveSupport::TestCase
  
  fixtures :products
  
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  def test_invalid_with_empty_attributes
    product = Product.new
    assert !product.valid?
    assert product.errors.invalid?(:title)
    assert product.errors.invalid?(:description)
    assert product.errors.invalid?(:price)
    assert product.errors.invalid?(:image_url)
  end
  
  def test_positive_price
    product = Product.new(:title        =>"My book title",
                          :description  => "yyy",
                          :image_url    => "zzz.jpg")
    product.price = -1
    assert !product.valid?
    assert_equal "should be at least 0.01", product.errors.on(:price)
    
    product.price = 0
    assert !product.valid?
    assert_equal "should be at least 0.01", product.errors.on(:price)

    product.price = 1
    assert product.valid?
  end
  
  def test_image_url
    ok  = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gifsets fred.gif.more }
    
    ok.each do |name|
      product = Product.new(:title => "My book title", 
                            :description => "yyy", 
                            :price => 25,
                            :image_url => name)
      assert product.valid?, product.errors.full_messages
    end

    bad.each do |name|
      product = Product.new(:title => "My book title", 
                            :description => "yyy", 
                            :price => 25,
                            :image_url => name)
      assert !product.valid?, "saving #{name}"
    end
  end
  
  def test_unique_title
    product = Product.new(:title        => products(:ruby_book).title,
                          :description  => "yyy",
                          :price        => 1,
                          :image_url    => "fred.gif")
    assert !product.save
    assert_equal ActiveRecord::Errors.default_error_messages[:taken], product.errors.on(:title)
  end
end
