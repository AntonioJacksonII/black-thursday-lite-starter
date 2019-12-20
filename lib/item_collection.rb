require 'csv'
require_relative 'item'
require_relative 'collection'

class ItemCollection < Collection

  def items
    @collection
  end

  def find(id)
    super(items, id)
  end

  def where(merchant_id)
    items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end
end
