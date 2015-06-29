module SpreeStoreCredits::PaymentMethodDecorator

  def self.included(base)
    base.class_eval do
      prepend(InstanceMethods)
    end
  end

  module InstanceMethods
    def store_credit?
      self.class == Spree::PaymentMethod::StoreCredit
    end
  end
end

Spree::PaymentMethod.class_eval do
  include SpreeStoreCredits::PaymentMethodDecorator
end
