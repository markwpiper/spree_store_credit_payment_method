module SpreeStoreCredits::ShipmentDecorator
  def self.included(base)
    base.state_machine.before_transition to: :shipped, do: :create_gift_cards

    base.class_eval do
      prepend(InstanceMethods)
    end
  end

  module InstanceMethods
    def create_gift_cards
      line_items.each do |item|
        item.quantity.times do
          Spree::VirtualGiftCard.create!(amount: item.price, currency: item.currency, purchaser: item.order.user, line_item: item) if item.gift_card?
        end
      end
    end
  end
end

Spree::Shipment.class_eval do
  include SpreeStoreCredits::ShipmentDecorator
end
