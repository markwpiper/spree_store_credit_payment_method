module Spree::LineItemDecorator
  def self.included(base)
    base.has_many :gift_cards, class_name: Spree::VirtualGiftCard
    base.delegate :gift_card?, :gift_card, to: :product
    base.class_eval do
      prepend(InstanceMethods)
    end
  end

  module InstanceMethods
    def redemption_codes
      gift_cards.map {|gc| {amount: gc.formatted_amount, redemption_code: gc.formatted_redemption_code}}
    end
  end
end

Spree::LineItem.class_eval do
  include(Spree::LineItemDecorator)
end
