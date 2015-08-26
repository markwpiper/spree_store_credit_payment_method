class Spree::StoreCreditCategory < ActiveRecord::Base
  GIFT_CARD_CATEGORY_NAME = 'Gift Card'

  belongs_to :credit_type, class_name: 'Spree::StoreCreditType', :foreign_key => 'type_id'
  delegate :non_expiring?, to: :credit_type

  validates_presence_of :type_id
  validates_presence_of :name
  validates_uniqueness_of :name
end
