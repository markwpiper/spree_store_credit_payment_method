module Spree::UserDecorator
  def self.included(base)
    base.has_many :store_credits, -> { includes(:credit_type) }
    base.has_many :store_credit_events, through: :store_credits

    base.class_eval do
      prepend(InstanceMethods)
    end
  end

  module InstanceMethods
    def total_available_store_credit
      store_credits.reload.to_a.sum{ |credit| credit.amount_remaining }
    end
  end
end

Spree::User.class_eval do
  include(Spree::UserDecorator)
end
