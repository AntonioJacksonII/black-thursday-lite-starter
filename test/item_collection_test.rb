require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_collection'

class ItemCollectionTest < Minitest::Test
  def setup
    @item_collection = ItemCollection.new("./test/fixtures/items_truncated.csv", Item)
    @item = @item_collection.items[2]
  end

  def test_it_exists
    assert_instance_of ItemCollection, @item_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @item_collection.items
    assert_equal 4, @item_collection.items.length
  end

  def test_it_can_create_items_from_csv
    assert_instance_of Item, @item
    assert_equal 263396013, @item.id
    assert_equal "Free standing Woden letters", @item.name
    assert_equal "Free standing wooden letters\n\n15cm\n\nAny colours", @item.description
    assert_equal 700, @item.unit_price
    assert_equal 12334185, @item.merchant_id
  end

  def test_it_can_find_by_id
    assert_equal @item, @item_collection.find(263396013)
  end

  def test_it_can_find_all_items_where_merchant_id
    second_merchant_item = @item_collection.items.first
    third_merchant_item = @item_collection.items[1]
    assert_equal [second_merchant_item, third_merchant_item, @item], @item_collection.where(12334185)
  end
end
