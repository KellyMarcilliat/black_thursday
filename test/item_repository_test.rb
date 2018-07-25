require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository.rb'
require_relative '../lib/item.rb'
require_relative '../lib/sales_engine.rb'
require_relative '../lib/merchant.rb'
require_relative '../lib/merchant_repository.rb'
require 'pry'

class ItemRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })


  end

  def test_it_exists
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    ir = ItemRepository.new(se.csv_hash[:items])
    assert_instance_of ItemRepository, ir
  end

  def test_it_creates_items
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    ir = ItemRepository.new(se.csv_hash[:items])
    assert_equal [ ] , ir.items
  end

  def test_all_array
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    ir = ItemRepository.new(se.csv_hash[:items])
    assert_equal [ ], ir.all
  end

  def test_can_find_by_id
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    ir = ItemRepository.new(se.csv_hash[:items])
    ir.create_items
    assert_equal Item, ir.find_by_id("263395237").class
  end

  def test_find_by_name
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    ir = ItemRepository.new(se.csv_hash[:items])
    ir.create_items
    assert_equal [ir.all[3]], [ir.find_by_name("Free standing Woden letters")]
#when i run this there are brackets that switch if i put brackets around both they pass?
  end

  def test_find_all_with_description
    se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv"
      })
    ir = ItemRepository.new(se.csv_hash[:items])
    ir.create_items
    assert_equal [ir.all[1]], ir.find_all_with_description("scrabble frames")
    #should i use items or all?
  end

    def test_find_all_by_price
      se = SalesEngine.from_csv({
        :items     => "./data/dummy_items.csv",
        :merchants => "./data/dummy_merchants.csv"
        })
      ir = ItemRepository.new(se.csv_hash[:items])
      ir.create_items
    #  ir.all.convert_unit_price_to_dollar_string
      assert_equal [ir.all[3]] , ir.find_all_by_price("700")
    end

    def test_find_all_by_price_range
      skip
      se = SalesEngine.from_csv({
        :items     => "./data/dummy_items.csv",
        :merchants => "./data/dummy_merchants.csv"
        })
      ir = ItemRepository.new(se.csv_hash[:items])
      ir.create_items
      ir.convert_unit_price_to_dollar_string
      assert_equal 2 , ir.find_all_by_price_in_range("13.00..14.00").count
    end

    def test_find_all_by_merchant_id
      se = SalesEngine.from_csv({
        :items     => "./data/dummy_items.csv",
        :merchants => "./data/dummy_merchants.csv"
        })
      ir = ItemRepository.new(se.csv_hash[:items])
      ir.create_items
      assert_equal [ir.all[0]], ir.find_all_by_merchant_id("12334141")
    end


end
