require_relative 'item'
require_relative 'merchant_collection'

class SalesEngine
  attr_reader :item_path, :merchant_path

  def self.from_csv(file_paths)
    item_path = file_paths[:items]
    merchant_path = file_paths[:merchants]

    SalesEngine.new(item_path, merchant_path)
  end

  def initialize(item_path, merchant_path)
    @item_path = item_path
    @merchant_path = merchant_path
  end

  def items
    Item.from_csv(@item_path)
    Item.all
  end

  def merchant_collection
    MerchantCollection.new(@merchant_path)
  end

  def top_item_producing_merchants
    items_by_merchant = Hash.new(0)
    items.each do |item|
      items_by_merchant[item.merchant_id] += 1
    end

    total_items = items.length
    total_merchants = merchant_collection.all.length
    avg_item_for_merchant = total_items / total_merchants.to_f

    squared_differences = items_by_merchant.map do |merchant_id, item_count|
      (item_count - avg_item_for_merchant)**2
    end

    avg_squared_difference = squared_differences.sum.to_f / squared_differences.length

    standard_deviation = Math.sqrt(avg_squared_difference)

    top_item_producer_ids = []
    items_by_merchant.each do |merchant_id, item_count|
      if item_count > avg_item_for_merchant + (standard_deviation * 3)
        top_item_producer_ids << merchant_id
      end
    end

    top_item_producer_ids.map do |id|
      merchant = merchant_collection.find(id)
      merchant.name
    end
  end
end
