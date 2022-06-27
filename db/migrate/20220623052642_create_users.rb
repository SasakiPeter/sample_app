class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      # created_atとupdated_atを生成している
      t.timestamps
    end
  end
end
