class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :user_image
      t.text :user_introduction

      t.timestamps
    end
  end
end
