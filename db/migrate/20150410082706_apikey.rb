class Apikey < ActiveRecord::Migration
  def change
    create_table :apikeys do |t|
      t.string :access_token, index: true, unique: true
      t.references :user, index: true, unique: true
      
      t.timestamps null: false
    end
    add_foreign_key :apikeys, :users
  end
end
