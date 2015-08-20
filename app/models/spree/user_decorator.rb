module Spree::UserDecorator
  def self.included(base)
    base.has_many :store_credits, -> { includes(:credit_type) }
    base.has_many :store_credit_events, through: :store_credits

    base.class_eval do
      prepend(InstanceMethods)
    end
  end

  module InstanceMethods
    def total_authorized_store_credit
      store_credits.reload.to_a.sum{ |credit| credit.amount_authorized }
    end

    def display_total_authorized_store_credit
      Spree::Money.new(total_authorized_store_credit)
    end

    def total_credited_store_credit
      store_credits.reload.to_a.sum{ |credit| credit.amount }
    end

    def display_total_credited_store_credit
      Spree::Money.new(total_credited_store_credit)
    end

    def total_available_store_credit
      store_credits.reload.to_a.sum{ |credit| credit.amount_remaining }
    end

    def display_total_available_store_credit
      Spree::Money.new(total_available_store_credit)
    end

    def total_used_store_credit
      store_credits.reload.to_a.sum{ |credit| credit.amount_used }
    end

    def display_total_used_store_credit
      Spree::Money.new(total_used_store_credit)
    end
  end
end

Spree::User.class_eval do
  include(Spree::UserDecorator)
end
