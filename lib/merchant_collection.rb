require_relative 'merchant'
require_relative 'collection'
require 'csv'

class MerchantCollection < Collection
  def all
    @merchants
  end

  def find(id)
    super(@merchants, id)
  end

  def create(merchant_name_info)
    new_id = all.last.id + 1
    merchant_info = merchant_name_info.merge({id: new_id})
    all << Merchant.new(merchant_info)
  end

  def destroy(merchant_id)
    merchant_to_delete = all.find {|merchant| merchant.id == merchant_id}

    all.delete(merchant_to_delete)
  end

  def update(merchant_info)
    merchant_to_update = all.find {|merchant| merchant.id == merchant_info[:id]}
    merchant_to_update.name = merchant_info[:name]
  end
end
