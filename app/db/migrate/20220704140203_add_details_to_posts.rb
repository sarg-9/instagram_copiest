# frozen_string_literal: true

class AddDetailsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :likes, :integer
  end
end
