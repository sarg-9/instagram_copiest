# frozen_string_literal: true

class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_column :users, :mobilenumber, :string
  end
end
