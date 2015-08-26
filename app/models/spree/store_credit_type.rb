module Spree
  class StoreCreditType < ActiveRecord::Base
    DEFAULT_TYPE_NAME = 'Expiring'

    has_many :store_credits, class_name: 'Spree::StoreCredit', foreign_key: 'type_id'

    validates_presence_of :name
    validates_uniqueness_of :name
    validates_numericality_of :priority

    def non_expiring?
      #TODO: make this a boolean field on the credit-type record instead of keying off the name
      name != 'Expiring'
    end
  end
end
