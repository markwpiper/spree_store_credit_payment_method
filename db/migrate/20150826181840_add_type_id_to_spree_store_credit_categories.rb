class AddTypeIdToSpreeStoreCreditCategories < ActiveRecord::Migration
  def change
    add_belongs_to :spree_store_credit_categories, :type, foreign_key: true
  end
end
