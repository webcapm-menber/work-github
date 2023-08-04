class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      
      t.string :name,         null: false #商品の名前
      t.string :introduction, null: false #商品の説明
      t.integer :price,       null: false #値段(税抜き価格)
      
      # 以下はチャレンジ機能
      t.integer :genre_id,    null: false                 #ジャンルid
      t.boolean :is_active,   null: false, default: false #販売ステータス
      
      t.timestamps
    end
  end
end
