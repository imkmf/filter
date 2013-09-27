class CreateCategoriesPodcasts < ActiveRecord::Migration
  def change
    create_table :categories_podcasts do |t|
      t.references :category, index: true
      t.references :podcast, index: true
    end
  end
end
